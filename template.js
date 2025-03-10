const getRequestHeader = require('getRequestHeader');
const getAllEventData = require('getAllEventData');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const makeString = require('makeString');
const makeInteger = require('makeInteger');
const sendHttpRequest = require('sendHttpRequest');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const getContainerVersion = require('getContainerVersion');

/**********************************************************************************************/

const isLoggingEnabled = determinateIsLoggingEnabled();
const traceId = isLoggingEnabled ? getRequestHeader('trace-id') : undefined;

const eventData = getAllEventData();

if (!isConsentGivenOrNotRequired()) {
  return data.gtmOnSuccess();
}

const url = eventData.page_location || getRequestHeader('referer');

if (url && url.lastIndexOf('https://gtm-msr.appspot.com/', 0) === 0) {
  return data.gtmOnSuccess();
}

const COOKIE_PREFIX = 'stape_sendlane_';
const actionHandlers = {
  addContactToList: handleAddContactToList,
  event: handleEvent
};

const handler = actionHandlers[data.type];
if (handler) {
  handler();
}

if (data.useOptimisticScenario) {
  data.gtmOnSuccess();
}

/**********************************************************************************************/
// Vendor related functions

function sendEvent(requestData) {
  const url = 'https://api.sendlane.com/v2' + requestData.path;
  const requestBody = requestData.body;
  
  if (isLoggingEnabled) {
    logToConsole(
      JSON.stringify({
        Name: 'Sendlane',
        Type: 'Request',
        TraceId: traceId,
        EventName: data.type,
        RequestMethod: 'POST',
        RequestUrl: url,
        RequestBody: requestBody
      })
    );
  }
  
  sendHttpRequest(
    url,
    (statusCode, headers, body) => {
      logToConsole(
        JSON.stringify({
          Name: 'Sendlane',
          Type: 'Response',
          TraceId: traceId,
          EventName: data.type,
          ResponseStatusCode: statusCode,
          ResponseHeaders: headers,
          ResponseBody: body,
        })
      );

      if (!data.useOptimisticScenario) {
        if (statusCode >= 200 && statusCode < 400) {
          data.gtmOnSuccess();
        } else {
          data.gtmOnFailure();
        }
      }
    },
    {
      headers: {
        Accept: 'application/json',
        Authorization: 'Bearer ' + data.apiToken,
        'Content-Type': 'application/json'
      },
      method: 'POST'
    },
    JSON.stringify(requestBody)
  );
}

function handleAddContactToList() {
  const mappedAddContactToListData = mapAddContactToList(eventData, data);
  if (validateContactData(mappedAddContactToListData)) {
    sendEvent({
      path: '/lists/' + data.listId + '/contacts',
      body: mappedAddContactToListData 
    });
  } else {
    if (isLoggingEnabled) {
      logToConsole(
        JSON.stringify({
          Name: 'Sendlane',
          Type: 'Message',
          TraceId: traceId,
          EventName: data.type,
          Message: 'No contact was added to list.',
          Reason: 'You must set at last the email or phone.'
        })
      );
    }
    data.gtmOnFailure();
  } 
}

function mapAddContactToList(eventData, data) {
  let mappedData = {
    contacts: [{}]
  };
  
  mappedData = addAddContactToListData(eventData, mappedData);
  mappedData = addAddContactToListCustomFieldsData(eventData, mappedData);

  return mappedData;
}

function addAddContactToListData(eventData, mappedData) {
  let contacts;
  const user_data = eventData.user_data || {};
  
  if (eventData.email) mappedData.contacts[0].email = eventData.email;
  else if (user_data.email_address) mappedData.contacts[0].email = user_data.email_address;
  else if (user_data.email) mappedData.contacts[0].email = user_data.email;
  else if (data.storeEmail) {
    let emailCookie = getCookieValues(COOKIE_PREFIX + 'email');
    if (emailCookie.length) mappedData.contacts[0].email = emailCookie[0];
  }

  if (eventData.phone) mappedData.contacts[0].phone = eventData.phone;
  else if (user_data.phone_number) mappedData.contacts[0].phone = user_data.phone_number;
  
  if (data.customerProperties) {
    data.customerProperties.forEach((d) => mappedData.contacts[0][d.name] = d.value);
  }
  
  if (mappedData.contacts[0].email && data.storeEmail) {
    storeCookie('email', mappedData.contacts[0].email);
  }
  
  return mappedData;
}

function addAddContactToListCustomFieldsData(eventData, mappedData) {
  if (data.customerCustomFields) {
    mappedData.contacts[0].custom_fields = data.customerCustomFields.map((d) => {
      return {
        id: makeInteger(d.id),
        value: makeString(d.value)
      };
    });
  }
  
  return mappedData;
}

function validateContactData(mappedAddContactToListData) {
  const contact = mappedAddContactToListData.contacts[0];
  return !!(contact.email || contact.phone);
}

function handleEvent() {
  const mappedEventData = mapEvent(eventData, data);
  sendEvent({
    path: '/tracking/event',
    body: mappedEventData 
  });
}

function mapEvent(eventData, data) {
  let mappedData = {
    token: data.customIntegrationToken,
    custom_event: data.eventName
  };
  
  mappedData = addEventUserData(eventData, mappedData);
  mappedData = addEventCustomData(eventData, mappedData);
 
  return mappedData;
}

function addEventUserData(eventData, mappedData) {
  const user_data = eventData.user_data || {};

  if (eventData.email) mappedData.email = eventData.email;
  else if (user_data.email_address) mappedData.email = user_data.email_address;
  else if (user_data.email) mappedData.email = user_data.email;
  else if (data.storeEmail) {
    let emailCookie = getCookieValues(COOKIE_PREFIX + 'email');
    if (emailCookie.length) mappedData.email = emailCookie[0];
  }

  if (eventData.phone) mappedData.phone = eventData.phone;
  else if (user_data.phone_number) mappedData.phone = user_data.phone_number;
  
  if (data.eventCustomerData) {
    data.eventCustomerData.forEach((d) => mappedData[d.name] = d.value);
  }
  
  if (mappedData.email && data.storeEmail) {
    storeCookie('email', mappedData.email);
  }
  
  return mappedData;
}

function addEventCustomData(eventData, mappedData) {
  if (data.eventCustomData) {
    mappedData.data = {};
    data.eventCustomData.forEach((d) => mappedData.data[d.name] = d.value);
  }
  
  return mappedData;
}

/**********************************************************************************************/
// Helpers

function storeCookie(name, value) {
  setCookie(COOKIE_PREFIX + name, value, {
    domain: data.overridenCookieDomain || 'auto',
    path: '/',
    samesite: 'Lax',
    secure: true,
    'max-age': 63072000, // 2 years
    httpOnly: false
  });
}

function isConsentGivenOrNotRequired() {
  if (data.adStorageConsent !== 'required') return true;
  if (eventData.consent_state) return !!eventData.consent_state.ad_storage;
  const xGaGcs = eventData['x-ga-gcs'] || ''; // x-ga-gcs is a string like "G110"
  return xGaGcs[2] === '1';
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(
    containerVersion &&
    (containerVersion.debugMode || containerVersion.previewMode)
  );

  if (!data.logType) {
    return isDebug;
  }

  if (data.logType === 'no') {
    return false;
  }

  if (data.logType === 'debug') {
    return isDebug;
  }

  return data.logType === 'always';
}

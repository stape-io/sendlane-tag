const encodeUri = require('encodeUri');
const getAllEventData = require('getAllEventData');

const getCookieValues = require('getCookieValues');
const getRequestHeader = require('getRequestHeader');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const makeInteger = require('makeInteger');
const makeString = require('makeString');
const sendHttpRequest = require('sendHttpRequest');
const setCookie = require('setCookie');

/*==============================================================================
==============================================================================*/

const eventData = getAllEventData();
const useOptimisticScenario = isUIFieldTrue(data.useOptimisticScenario);

if (!isConsentGivenOrNotRequired(data, eventData)) {
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
  handler(data, eventData);
}

if (useOptimisticScenario) {
  data.gtmOnSuccess();
}

/*==============================================================================
  Vendor related functions
==============================================================================*/

function sendEvent(data, requestData) {
  const url = 'https://api.sendlane.com/v2' + requestData.path;
  const requestBody = requestData.body;

  sendHttpRequest(
    url,
    (statusCode, headers, body) => {
      if (!useOptimisticScenario) {
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

function handleAddContactToList(data, eventData) {
  const mappedAddContactToListData = mapAddContactToList(data, eventData);
  if (validateContactData(mappedAddContactToListData)) {
    sendEvent(data, {
      path: '/lists/' + encodeUri(data.listId) + '/contacts',
      body: mappedAddContactToListData
    });
  } else {
    log({
      Name: 'Sendlane',
      Type: 'Message',
      EventName: data.type,
      Message: '🛑 [ERROR] No contact was added to list.',
      Reason: 'You must set at last the email or phone.'
    });
    data.gtmOnFailure();
  }
}

function mapAddContactToList(data, eventData) {
  let mappedData = {
    contacts: [{}]
  };

  mappedData = addAddContactToListData(data, eventData, mappedData);
  mappedData = addAddContactToListCustomFieldsData(data, mappedData);

  return mappedData;
}

function addAddContactToListData(data, eventData, mappedData) {
  const user_data = eventData.user_data || {};

  const email = eventData.email || user_data.email_address || user_data.email;
  if (email) mappedData.contacts[0].email = email;
  else if (data.storeEmail) {
    let emailCookie = getCookieValues(COOKIE_PREFIX + 'email')[0];
    if (emailCookie) mappedData.contacts[0].email = emailCookie;
  }

  const phone = eventData.phone || user_data.phone_number;
  if (phone) mappedData.contacts[0].phone = phone;

  if (data.customerProperties) {
    data.customerProperties.forEach((d) => (mappedData.contacts[0][d.name] = d.value));
  }

  if (mappedData.contacts[0].email && data.storeEmail) {
    storeCookie('email', mappedData.contacts[0].email);
  }

  return mappedData;
}

function addAddContactToListCustomFieldsData(data, mappedData) {
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

function handleEvent(data, eventData) {
  const mappedEventData = mapEvent(data, eventData);
  sendEvent(data, {
    path: '/tracking/event',
    body: mappedEventData
  });
}

function mapEvent(data, eventData) {
  let mappedData = {
    token: data.customIntegrationToken,
    custom_event: data.eventName
  };

  mappedData = addEventUserData(data, eventData, mappedData);
  mappedData = addEventCustomData(data, mappedData);

  return mappedData;
}

function addEventUserData(data, eventData, mappedData) {
  const user_data = eventData.user_data || {};

  const email = eventData.email || user_data.email_address || user_data.email;
  if (email) mappedData.email = email;
  else if (data.storeEmail) {
    let emailCookie = getCookieValues(COOKIE_PREFIX + 'email')[0];
    if (emailCookie) mappedData.email = emailCookie;
  }

  const phone = eventData.phone || user_data.phone_number;
  if (phone) mappedData.phone = phone;

  if (data.eventCustomerData) {
    data.eventCustomerData.forEach((d) => (mappedData[d.name] = d.value));
  }

  if (mappedData.email && data.storeEmail) {
    storeCookie('email', mappedData.email);
  }

  return mappedData;
}

function addEventCustomData(data, mappedData) {
  if (data.eventCustomData) {
    mappedData.data = {};
    data.eventCustomData.forEach((d) => (mappedData.data[d.name] = d.value));
  }

  return mappedData;
}

/*==============================================================================
  Helpers
==============================================================================*/

function isUIFieldTrue(field) {
  return [true, 'true'].indexOf(field) !== -1;
}

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

function isConsentGivenOrNotRequired(data, eventData) {
  if (data.adStorageConsent !== 'required') return true;
  if (eventData.consent_state) return !!eventData.consent_state.ad_storage;
  const xGaGcs = eventData['x-ga-gcs'] || ''; // x-ga-gcs is a string like "G110"
  return xGaGcs[2] === '1';
}

function log(rawDataToLog) {
  rawDataToLog.TraceId = getRequestHeader('trace-id');
  logToConsole(JSON.stringify(rawDataToLog));
}

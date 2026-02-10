/// <reference path="./server-gtm-sandboxed-apis.d.ts" />

const BigQuery = require('BigQuery');
const encodeUri = require('encodeUri');
const getAllEventData = require('getAllEventData');
const getContainerVersion = require('getContainerVersion');
const getCookieValues = require('getCookieValues');
const getRequestHeader = require('getRequestHeader');
const getTimestampMillis = require('getTimestampMillis');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const makeInteger = require('makeInteger');
const makeString = require('makeString');
const sendHttpRequest = require('sendHttpRequest');
const setCookie = require('setCookie');

/*==============================================================================
==============================================================================*/

const traceId = getRequestHeader('trace-id');
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

  log({
    Name: 'Sendlane',
    Type: 'Request',
    TraceId: traceId,
    EventName: data.type,
    RequestMethod: 'POST',
    RequestUrl: url,
    RequestBody: requestBody
  });

  sendHttpRequest(
    url,
    (statusCode, headers, body) => {
      log({
        Name: 'Sendlane',
        Type: 'Response',
        TraceId: traceId,
        EventName: data.type,
        ResponseStatusCode: statusCode,
        ResponseHeaders: headers,
        ResponseBody: body
      });

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
      TraceId: traceId,
      EventName: data.type,
      Message: 'No contact was added to list.',
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
  const logDestinationsHandlers = {};
  if (determinateIsLoggingEnabled()) logDestinationsHandlers.console = logConsole;
  if (determinateIsLoggingEnabledForBigQuery()) logDestinationsHandlers.bigQuery = logToBigQuery;

  const keyMappings = {
    // No transformation for Console is needed.
    bigQuery: {
      Name: 'tag_name',
      Type: 'type',
      TraceId: 'trace_id',
      EventName: 'event_name',
      RequestMethod: 'request_method',
      RequestUrl: 'request_url',
      RequestBody: 'request_body',
      ResponseStatusCode: 'response_status_code',
      ResponseHeaders: 'response_headers',
      ResponseBody: 'response_body'
    }
  };

  for (const logDestination in logDestinationsHandlers) {
    const handler = logDestinationsHandlers[logDestination];
    if (!handler) continue;

    const mapping = keyMappings[logDestination];
    const dataToLog = mapping ? {} : rawDataToLog;

    if (mapping) {
      for (const key in rawDataToLog) {
        const mappedKey = mapping[key] || key;
        dataToLog[mappedKey] = rawDataToLog[key];
      }
    }

    handler(dataToLog);
  }
}

function logConsole(dataToLog) {
  logToConsole(JSON.stringify(dataToLog));
}

function logToBigQuery(dataToLog) {
  const connectionInfo = {
    projectId: data.logBigQueryProjectId,
    datasetId: data.logBigQueryDatasetId,
    tableId: data.logBigQueryTableId
  };

  dataToLog.timestamp = getTimestampMillis();

  ['request_body', 'response_headers', 'response_body'].forEach((p) => {
    dataToLog[p] = JSON.stringify(dataToLog[p]);
  });

  BigQuery.insert(connectionInfo, [dataToLog], { ignoreUnknownValues: true });
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

function determinateIsLoggingEnabledForBigQuery() {
  if (data.bigQueryLogType === 'no') return false;
  return data.bigQueryLogType === 'always';
}

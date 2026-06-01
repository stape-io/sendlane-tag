___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Sendlane Tag by Stape",
  "brand": {
    "id": "brand_dummy",
    "displayName": "stape.io",
    "categories": [
      "MARKETING",
      "EMAIL_MARKETING",
      "CONVERSIONS"
    ],
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADwAAAA8CAMAAAANIilAAAAAAXNSR0IB2cksfwAAAARnQU1BAACxjwv8YQUAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAhNQTFRFAAAAAAAA/wAA/wCA/1VV/0CA/zNm/yuA/0lt/0CA/zlx/0Z0/0CA/zt2/0CA/zx4/zZ5/0Bz/z15/zd6/0B1/zt2/0B2/z57/zx3/zp7/0B4/z58/z51/zl5/z53/zx3/zp6/z16/zx4/zt2/zt2/z15/zx3/z15/zx4/zt6/z54/z16/zx4/zt2/zt3/z13/z15/zt5/z14/zx4/zt3/zt4/z13/zx4/zx3/zt4/zx5/zx3/zx5/zx4/zt5/z15/zx4/zt4/z13/zx5/zx3/zt5/z14/zx5/zx4/zt5/z15/zx4/zx3/zt4/z13/zx3/z13/zx4/zx4/zt5/z14/zx4/zt5/z14/zx3/z13/zx4/zx3/zt5/z14/zx5/zx5/z14/zx4/zx3/zt4/zx3/zx4/zx3/z14/zx4/zx4/zt4/zx5/zx5/zx5/zx4/zx3/zx3/zx4/zt4/z14/zx4/z14/zx4/zx5/z14/zx3/zt4/zx3/zx4/zt4/zx4/zx4/z14/zx5/z14/zx5/zx4/zx3/zt4/zx3/zx4/zx4/zx4/zx4/zx4/zx4/zx4/z14/zx5/zx4/zx3/zt4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/z14/zx4/zx3/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4/zx4////teaUTgAAAAF0Uk5TAEDm2GYAAAABYktHRACIBR1IAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH6gUcETE6tJHiVAAAATVJREFUSMelV0sWwyAI9AYcpS9XkwWP27ebJmr4DMqqSsYBFJ22Zhj9rHPbMfobH2A30DTZCZb0AFtC35jr/iVl7DjgDewz1A2sMZFj+3tKyryVvO0QMe7upAdxe6W5EG63rshpYS84AtDiMI/nXIpx89QlXNoqXpssTHr2882YofXlHxEZevXP41rk3loc75cTZ9bfT94WT9be69aw5VUMrWgHWGjHqwjabfvihZT0D8RcqTd20b3usvA6RB86tBjmCaOo7dw6+4+P1ruKY2zYzxJj5ZXSMKNJNxvlECLsBhTLiyoUe2XF1I2TUodUWfrQRdrEW7wjLzRnSSO6Yg7uY8icaJ+1qgscNBc05PppTX/O3FdR+Y5UvK97iTfU/olabyfYoUw7/1Amcmll67u0A3n+2RdzhGhBnb7fxgAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Add contacts to list and send events to Sendlane.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "configGroup",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "type",
        "displayName": "Type",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "event",
            "displayValue": "Event"
          },
          {
            "value": "addContactToList",
            "displayValue": "Add Contact to List"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "event",
        "alwaysInSummary": true
      },
      {
        "type": "TEXT",
        "name": "apiToken",
        "displayName": "API Token",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "\u003ca href\u003d\"https://help.sendlane.com/article/706-how-to-generate-authorization-tokens#api\" target\u003d\"_blank\"\u003eLearn more\u003c/a\u003e about how to get the API Token."
      },
      {
        "type": "TEXT",
        "name": "customIntegrationToken",
        "displayName": "Custom Integration Token",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "\u003ca href\u003d\"https://help.sendlane.com/article/706-how-to-generate-authorization-tokens#custom-integration\" target\u003d\"_blank\"\u003eLearn more\u003c/a\u003e about how to get the Custom Integration Token.",
        "enablingConditions": [
          {
            "paramName": "type",
            "paramValue": "event",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "eventName",
        "displayName": "Event Name",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "type",
            "paramValue": "event",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "listId",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "NUMBER"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "type",
            "paramValue": "addContactToList",
            "type": "EQUALS"
          }
        ],
        "displayName": "List ID"
      },
      {
        "type": "CHECKBOX",
        "name": "useOptimisticScenario",
        "checkboxText": "Use Optimistic Scenario",
        "simpleValueType": true,
        "help": "The tag will call gtmOnSuccess() without waiting for a response from the API. This will speed up sGTM response time however your tag will always return the status fired successfully even in case it is not."
      },
      {
        "type": "CHECKBOX",
        "name": "overrideCookieDomain",
        "checkboxText": "Override the cookie domain",
        "simpleValueType": true,
        "subParams": [
          {
            "type": "TEXT",
            "name": "overridenCookieDomain",
            "displayName": "Cookie Domain",
            "simpleValueType": true,
            "enablingConditions": [
              {
                "paramName": "overrideCookieDomain",
                "paramValue": true,
                "type": "EQUALS"
              }
            ],
            "help": "",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "valueHint": "example.com"
          }
        ],
        "help": "Enable this option to override the cookie domain.\n\u003cbr\u003e\nEnter your website\u0027s top-level domain as a fixed value (e.g., example.com).\n\u003cbr\u003e\nIf left unchecked, the domain will be automatically determined using the following priority:\n\u003cul\u003e\n\u003cli\u003eDomain of the \u003ci\u003eForwarded\u003c/i\u003e header (if present).\u003c/li\u003e\n\u003cli\u003eDomain of the \u003ci\u003eX-Forwarded-Host\u003c/i\u003e header (if present).\u003c/li\u003e\n\u003cli\u003eDomain of the \u003ci\u003eHost\u003c/i\u003e header.\u003c/li\u003e\n\u003c/ul\u003e",
        "enablingConditions": [
          {
            "paramName": "type",
            "paramValue": "event",
            "type": "EQUALS"
          },
          {
            "paramName": "type",
            "paramValue": "addContactToList",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "storeEmail",
        "checkboxText": "Store email in cookies",
        "simpleValueType": true,
        "help": "Allow storing the email in cookies if it is provided and use it as a fallback if it is not provided for the current event or contact addition to list.",
        "enablingConditions": [
          {
            "paramName": "type",
            "paramValue": "event",
            "type": "EQUALS"
          },
          {
            "paramName": "type",
            "paramValue": "addContactToList",
            "type": "EQUALS"
          }
        ]
      }
    ]
  },
  {
    "displayName": "Event Customer Data Properties",
    "name": "eventCustomerDataListGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "name": "eventCustomerData",
        "simpleTableColumns": [
          {
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "isUnique": true,
            "type": "SELECT",
            "selectItems": [
              {
                "value": "email",
                "displayValue": "Email"
              },
              {
                "value": "phone",
                "displayValue": "Phone"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "type": "SIMPLE_TABLE",
        "newRowButtonText": "Add property"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "event",
        "type": "EQUALS"
      }
    ]
  },
  {
    "displayName": "Event Custom Data",
    "name": "eventCustomDataListGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "LABEL",
        "name": "eventCustomDataHelpText",
        "displayName": "Define custom properties to include any additional data for downstream automation. These properties are flexible and can be structured as needed.\n\u003cbr\u003e\nCheck more information on the \u003ca href\u003d\"https://sendlane.stoplight.io/docs/api-documentation/770c071e56b76-custom-event\" target\u003d\"_blank\"\u003edocumentation\u003c/a\u003e."
      },
      {
        "name": "eventCustomData",
        "simpleTableColumns": [
          {
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "",
            "displayName": "Property",
            "name": "name",
            "isUnique": true,
            "type": "TEXT",
            "selectItems": [
              {
                "value": "last_name",
                "displayValue": "Last Name"
              },
              {
                "value": "phone",
                "displayValue": "Phone"
              },
              {
                "value": "email_consent",
                "displayValue": "Email Consent"
              },
              {
                "value": "sms_consent",
                "displayValue": "SMS Consent"
              },
              {
                "value": "tag_ids",
                "displayValue": "Tag IDs"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Value",
            "name": "value",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "type": "SIMPLE_TABLE",
        "newRowButtonText": "Add property"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "event",
        "type": "EQUALS"
      }
    ]
  },
  {
    "displayName": "Customer Properties",
    "name": "customerPropertiesListGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "LABEL",
        "name": "customerPropertiesHelpText",
        "displayName": "See this \u003ca href\u003d\"https://sendlane.stoplight.io/docs/api-documentation/0228d68c83aa4-create-list-contact#request-body\" target\u003d\"_blank\"\u003edocumentation\u003c/a\u003e for more details on what data parameters you can add to the call and their format."
      },
      {
        "name": "customerProperties",
        "simpleTableColumns": [
          {
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ],
            "defaultValue": "",
            "displayName": "Property Name",
            "name": "name",
            "isUnique": true,
            "type": "SELECT",
            "selectItems": [
              {
                "value": "email",
                "displayValue": "Email"
              },
              {
                "value": "first_name",
                "displayValue": "First Name"
              },
              {
                "value": "last_name",
                "displayValue": "Last Name"
              },
              {
                "value": "phone",
                "displayValue": "Phone"
              },
              {
                "value": "email_consent",
                "displayValue": "Email Consent"
              },
              {
                "value": "sms_consent",
                "displayValue": "SMS Consent"
              },
              {
                "value": "tag_ids",
                "displayValue": "Tag IDs"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Property Value",
            "name": "value",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "type": "SIMPLE_TABLE",
        "newRowButtonText": "Add property",
        "enablingConditions": []
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "addContactToList",
        "type": "EQUALS"
      }
    ]
  },
  {
    "displayName": "Customer Custom Fields",
    "name": "customerCustomFieldsListGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "LABEL",
        "name": "customerCustomFieldsHelpText",
        "displayName": "See this \u003ca href\u003d\"https://help.sendlane.com/article/331-custom-fields\" target\u003d\"_blank\"\u003edocumentation\u003c/a\u003e for more details on how to create custom fields."
      },
      {
        "name": "customerCustomFields",
        "simpleTableColumns": [
          {
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              },
              {
                "type": "POSITIVE_NUMBER"
              }
            ],
            "defaultValue": "",
            "displayName": "Custom Field ID",
            "name": "id",
            "isUnique": true,
            "type": "TEXT",
            "selectItems": [
              {
                "value": "last_name",
                "displayValue": "Last Name"
              },
              {
                "value": "phone",
                "displayValue": "Phone"
              },
              {
                "value": "email_consent",
                "displayValue": "Email Consent"
              },
              {
                "value": "sms_consent",
                "displayValue": "SMS Consent"
              },
              {
                "value": "tag_ids",
                "displayValue": "Tag IDs"
              }
            ]
          },
          {
            "defaultValue": "",
            "displayName": "Custom Field Value",
            "name": "value",
            "type": "TEXT",
            "valueValidators": [
              {
                "type": "NON_EMPTY"
              }
            ]
          }
        ],
        "type": "SIMPLE_TABLE",
        "newRowButtonText": "Add custom field",
        "enablingConditions": []
      }
    ],
    "enablingConditions": [
      {
        "paramName": "type",
        "paramValue": "addContactToList",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "tagExecutionConsentSettingsGroup",
    "displayName": "Tag Execution Consent Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "adStorageConsent",
        "radioItems": [
          {
            "value": "optional",
            "displayValue": "Send data always"
          },
          {
            "value": "required",
            "displayValue": "Send data in case marketing consent given",
            "help": "Aborts the tag execution if marketing consent (\u003ci\u003ead_storage\u003c/i\u003e Google Consent Mode or Stape\u0027s Data Tag parameter) is not given."
          }
        ],
        "simpleValueType": true,
        "defaultValue": "optional"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

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


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "trace-id"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "stape_sendlane_email"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "stape_sendlane_email"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://api.sendlane.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Event Request
  code: |
    const expectedValue = 'test';
    mockData.type = 'event';

    mockData.customIntegrationToken = '123customintegrationtoken';
    mockData.eventName = expectedValue;
    mockData.eventCustomData = [{ "name": "prop_test", "value": expectedValue }, { "name": "another_prop_test", "value": expectedValue }];
    mockData.eventCustomerData = [{ "name": 'email', "value": expectedValue }, { "name": 'phone', "value": expectedValue }];

    mock('sendHttpRequest', (url, callback, options, body) => {
      const bodyParsed = JSON.parse(body);
      assertThat(url).isEqualTo('https://api.sendlane.com/v2/tracking/event');
      assertThat(options.method).isEqualTo('POST');
      assertThat(options.headers.Authorization).isEqualTo('Bearer ' + mockData.apiToken);
      assertThat(bodyParsed.custom_event).isEqualTo(expectedValue);
      assertThat(bodyParsed.email).isEqualTo(expectedValue);
      assertThat(bodyParsed.phone).isEqualTo(expectedValue);
      assertThat(bodyParsed.data.prop_test).isEqualTo(expectedValue);
      assertThat(bodyParsed.data.another_prop_test).isEqualTo(expectedValue);
    });

    runCode(mockData);

    assertApi('sendHttpRequest').wasCalled();
- name: Add Contact to List Request
  code: |-
    const expectedValue = 'test';
    const listIdExpectedValue = '123';
    const expectedCustomFields = [{ "id": 123, "value": expectedValue }, { "id": 111, "value": expectedValue }];

    mockData.type = 'addContactToList';
    mockData.listId = listIdExpectedValue;
    mockData.customerProperties = [{ "name": "email", "value": expectedValue }, { "name": "email_consent", "value": expectedValue }, { "name": "first_name", "value": expectedValue }];
    mockData.customerCustomFields = expectedCustomFields;

    mock('sendHttpRequest', (url, callback, options, body) => {
      const bodyParsed = JSON.parse(body);
      assertThat(url).isEqualTo('https://api.sendlane.com/v2/lists/' + listIdExpectedValue + '/contacts');
      assertThat(options.method).isEqualTo('POST');
      assertThat(options.headers.Authorization).isEqualTo('Bearer ' + mockData.apiToken);
      assertThat(bodyParsed.contacts[0].email).isEqualTo(expectedValue);
      assertThat(bodyParsed.contacts[0].email_consent).isEqualTo(expectedValue);
      assertThat(bodyParsed.contacts[0].first_name).isEqualTo(expectedValue);
      assertThat(bodyParsed.contacts[0].custom_fields).isEqualTo(expectedCustomFields);
    });

    runCode(mockData);

    assertApi('sendHttpRequest').wasCalled();
- name: Store Email in Cookies in Any Action Type
  code: |-
    const expectedValue = 'test';

    mockData.type = 'event';
    mockData.customIntegrationToken = '123';
    mockData.eventCustomerData = [{ "name": "email", "value": expectedValue }];
    mockData.storeEmail = true;

    runCode(mockData);

    assertApi('setCookie').wasCalledWith('stape_sendlane_email', expectedValue, {
      domain: 'auto',
      path: '/',
      samesite: 'Lax',
      secure: true,
      'max-age': 63072000,
      httpOnly: false
    });
- name: Store Email in Cookies in Add Contact to List
  code: |-
    const expectedValue = 'test';

    mockData.type = 'event';
    mockData.customIntegrationToken = '123';
    mockData.eventCustomerData = [{ "name": "email", "value": expectedValue }];
    mockData.storeEmail = true;

    runCode(mockData);

    assertApi('setCookie').wasCalledWith('stape_sendlane_email', expectedValue, {
      domain: 'auto',
      path: '/',
      samesite: 'Lax',
      secure: true,
      'max-age': 63072000,
      httpOnly: false
    });
- name: Override Cookie Domain
  code: |-
    const expectedValue = 'test';
    const expectedCookieDomain = 'example.com';

    mockData.type = 'event';
    mockData.customIntegrationToken = '123';
    mockData.eventCustomerData = [{ "name": "email", "value": expectedValue }];
    mockData.storeEmail = true;
    mockData.overrideCookieDomain = true;
    mockData.overridenCookieDomain = expectedCookieDomain;

    mock('setCookie', function(name, value, options) {
      assertThat(options.domain).isEqualTo(expectedCookieDomain);
    });

    runCode(mockData);
setup: "const Promise = require('Promise');\nconst JSON = require('JSON');\nconst\
  \ makeInteger = require('makeInteger');\nconst Object = require('Object');\nconst\
  \ callLater = require('callLater');\n\nconst mergeObj = (target, source) => {\n\
  \  for (const key in source) {\n    if (source.hasOwnProperty(key)) target[key]\
  \ = source[key];\n  }\n  return target;\n};\n\nconst expectedBigQuerySettings =\
  \ {\n  logBigQueryProjectId: 'logBigQueryProjectId',\n  logBigQueryDatasetId: 'logBigQueryDatasetId',\n\
  \  logBigQueryTableId: 'logBigQueryTableId'\n};\n\nconst requiredConsoleKeys = ['Type',\
  \ 'TraceId', 'Name'];\nconst requiredBqKeys = ['timestamp', 'type', 'trace_id',\
  \ 'tag_name'];\nconst expectedBqOptions = { ignoreUnknownValues: true };\n\nconst\
  \ mockData = {\n  apiToken: '123token'\n};\n\nmock('sendHttpRequest', (requestUrl,\
  \ callback, requestOptions, requestBody) => {\n  if (typeof callback === 'function')\
  \ {\n    callback(200);\n  } else {\n    requestBody = requestOptions;\n    requestOptions\
  \ = callback;\n    return Promise.create((resolve, reject) => {\n      resolve({\
  \ statusCode: 200 });\n    });  \n  }\n});\n\nmock('getRequestHeader', (header)\
  \ => {\n  if (header === 'trace-id') return 'expectedTraceId';\n});\n\nmock('getTimestampMillis',\
  \ 1747945830456);"


___NOTES___

2026-05-25 Change Notes:
 - Logging removal.

Created on 3/1/2025, 7:53:58 PM


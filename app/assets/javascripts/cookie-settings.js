const cookiePreferenceMap = new Map();

const getGrantedText = function (state) { return state ? 'granted' : 'not granted'; };

const removeGaCookies = () => {
  const cookieList = Object.keys(Cookies.get());
  const unwantedCookieList = [];

  for (let i = 0; i < cookieList.length; i++) {
    const cookieName = cookieList[i];

    if (cookieName.startsWith('_ga') || cookieName.startsWith('_gi')) unwantedCookieList.push(cookieName);
  }

  unwantedCookieList.forEach((cookieName) => Cookies.remove(cookieName));
};

const removeGlassboxCookies = () => {
  const cookieList = Object.keys(Cookies.get());
  const unwantedCookieList = [];

  for (let i = 0; i < cookieList.length; i++) {
    const cookieName = cookieList[i];

    if (cookieName.startsWith('_cls')) unwantedCookieList.push(cookieName);
  }

  unwantedCookieList.forEach((cookieName) => Cookies.remove(cookieName));
};

const updateDataLayer = cookiePreferences => {
  if (window.dataLayer) {
    window.dataLayer.push({
      event: "gtm_consent_update",
      usage_consent: getGrantedText(cookiePreferences.usage),
      glassbox_consent: getGrantedText(cookiePreferences.glassbox),
    })
  }
}

$(() => {
  $('#accept-cookies').on('click', (e) => {
    e.preventDefault();

    Cookies.set('rmi_cookie_settings_viewed', 'true', { expires: 365 });

    cookiePreferenceMap.set('usage', true);
    cookiePreferenceMap.set('glassbox', true);
    Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 });

    updateDataLayer(JSON.parse(Cookies.get('cookie_preferences')))

    $('#cookie-options-container').hide();
    $('#cookies-accepted-container').show();
  });

  $('#reject-cookies').on('click', (e) => {
    e.preventDefault();

    Cookies.set('rmi_cookie_settings_viewed', 'true', { expires: 365 });

    cookiePreferenceMap.set('usage', false);
    cookiePreferenceMap.set('glassbox', false);
    Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 });

    updateDataLayer(JSON.parse(Cookies.get('cookie_preferences')))
    removeGaCookies();
    removeGlassboxCookies();

    $('#cookie-options-container').hide();
    $('#cookies-rejected-container').show();
  });

  $('#save-cookie-settings-button').on('click', () => {
    Cookies.set('rmi_cookie_settings_viewed', 'true', { expires: 365 });

    if ($('input[name=ga_cookie_usage]:checked').val() === 'true') {
      cookiePreferenceMap.set('usage', true);
      Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 });
    } else {
      cookiePreferenceMap.set('usage', false);
      Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 });
      removeGaCookies();
    }

    if ($('input[name=glassbox_cookie_usage]:checked').val() === 'true') {
      cookiePreferenceMap.set('glassbox', true);
      Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 })
    } else {
      cookiePreferenceMap.set('glassbox', false);
      Cookies.set('cookie_preferences', Object.fromEntries(cookiePreferenceMap), { expires: 365 })
      removeGlassboxCookies();
    }

    updateDataLayer(JSON.parse(Cookies.get('cookie_preferences')))

    $('#cookie-settings-saved').show();
    $('html, body').animate({ scrollTop: $('#cookie-settings-saved').offset().top }, 'slow');
  });
});


document.addEventListener('DOMContentLoaded', () => {
  if (Cookies.get('rmi_cookie_settings_viewed') === 'true') $('#cookie-consent-container').hide();
});

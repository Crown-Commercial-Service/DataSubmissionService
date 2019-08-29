# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self

  policy.style_src   :self, 'https://fonts.googleapis.com'
  # For loading fonts referenced by the aforementioned styles
  # (https://fonts.gstatic.com at time of writing, but I see nothing to
  # suggest we can hardcode this host)
  policy.font_src    :self, :https

  # script-src and img-src settings required for Google Tag Manager;
  # script-src, img-src, and connect-src settings required for Google Analytics:
  # https://developers.google.com/tag-manager/web/csp
  policy.script_src  :self, :unsafe_inline, 'https://www.googletagmanager.com', 'https://www.google-analytics.com', 'https://ssl.google-analytics.com'
  policy.img_src     :self, 'https://www.googletagmanager.com', 'https://www.google-analytics.com'
  policy.connect_src :self, 'https://www.google-analytics.com'
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true

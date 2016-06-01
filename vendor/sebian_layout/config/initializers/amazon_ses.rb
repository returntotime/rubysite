creds = Aws::Credentials.new("AKIAIMJ4UYBPNV2Z2KSA", "ezlay/aQwe2AWYcbsltYDM1YXNDwWlHm02NH3jX6")
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk, credentials: creds, region: 'us-west-2')
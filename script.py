import os, plistlib, json, requests

webhook_url = 'https://hooks.slack.com/services/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'

dir_path = os.getcwd()
plist_path = dir_path+'/FeatureFlags/Features.plist'

pl = plistlib.readPlist(plist_path)

slack_data = pl

response = requests.post(
    webhook_url, json={"text":"Features\n"+json.dumps(slack_data)},
    headers={'Content-Type': 'application/json'}
)

if response.status_code != 200:
    raise ValueError(
        'Request to slack returned an error %s, the response is:\n%s'
        % (response.status_code, response.text)
    )

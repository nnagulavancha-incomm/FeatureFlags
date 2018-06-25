import os, plistlib

dir_path = os.getcwd()
plist_path = dir_path+'/FeatureFlags/Features.plist'

pl = plistlib.readPlist(plist_path)

print(pl)

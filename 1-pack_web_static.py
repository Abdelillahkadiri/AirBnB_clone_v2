from fabric.api import local
from datetime import datetime
import os

def do_pack():

 try:
 # Create versions folder if it doesn't exist
 if not os.path.exists("versions"):
 local("mkdir -p versions")

 # Generate timestamp for the archive name
 timestamp = datetime.now().strftime("%Y%m%d%H%M%S")

 # Create the archive
 archive_name = "web_static_{}.tgz".format(timestamp)
 local("tar -cvzf versions/{} web_static".format(archive_name))

 # Return the archive path
 return os.path.join("versions", archive_name)
 except Exception as e:
 print("Error occurred:", e)
 return None

from email.MIMEMultipart import MIMEMultipart
from email import Encoders
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
import smtplib, os, time

def sendkillermail(filepath,name,friends,lastwords,plattform):
	message = MIMEMultipart()
	message.add_header('Subject', 'new suicidemachine user')
	message.add_header('From','suicide@moddr.net')
	message.add_header('To','killer@moddr.net')
	message.attach(MIMEText(name + "\n" + friends + "\n" + lastwords + "\n" + plattform)) # plain text alternative

	part = MIMEBase('application', "octet-stream")
	part.set_payload( open(filepath,"rb").read() )
	Encoders.encode_base64(part)
	part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(filepath))
	message.attach(part)

	server = smtplib.SMTP("moddr.net")
	try:
		failed = server.sendmail("suicide@moddr.net", "killer@moddr.net", message.as_string())
		server.close()
	except Exception, e:
		errorMsg = "Unable to send email. Error: %s" % str(e)

#sendkillermail("/usr/lib/cgi-bin/killer.jpg","frescogamba","666","last words","facebook")

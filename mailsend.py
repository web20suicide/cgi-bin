from email.MIMEMultipart import MIMEMultipart
from email import Encoders
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
import os, smtplib, time

def sendkillermail(filepath,name,friends,plattform):
	message = MIMEMultipart()
	message.add_header('Subject', 'new suicidemachine user')
	message.attach(MIMEText(name + "\n" + friends + "\n" + plattform)) # plain text alternative

	part = MIMEBase('application', "octet-stream")
	part.set_payload( open(filePath,"rb").read() )
	Encoders.encode_base64(part)
	part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(filePath))
	message.attach(part)

	server = smtplib.SMTP("moddr.net")
	try:
		failed = server.sendmail("suicide@moddr.net", "killer@moddr.net", message.as_string())
		server.close()
	except Exception, e:
		errorMsg = "Unable to send email. Error: %s" % str(e)

filePath = "/var/www/w2sm/img/happy2010_web.png"
sendkillermail(filePath,"ljudmila","333","facebook")

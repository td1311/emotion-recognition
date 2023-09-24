from asari.api import Sonar
sonar = Sonar()
resp = sonar.ping(text="広告多すぎる♡")
print(resp)
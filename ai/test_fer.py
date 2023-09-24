from fer import FER
import cv2

img = cv2.imread("ai/face.jpg")
detector = FER()
resp = detector.detect_emotions(img)
print(resp)
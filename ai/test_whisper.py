import whisper

model = whisper.load_model("base")
result = model.transcribe("ai/audio.mp4", fp16=False)
print(result["text"])
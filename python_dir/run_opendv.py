import cv2

video_path = r'upload.mp4'

videoCapture = cv2.VideoCapture(video_path)

i=0
  
while True:
    success, frame = videoCapture.read()
    if success:
        i += 1
        if i % 60 == 0:
            print('i = ', i)
            address = './output/image' + str(i) + '.jpg'
            cv2.imwrite(address, frame)
    else:
        print('end')
        break

import cv2 # 安装依赖库
# 汲取了网上多家之长

video_path = r'BenOR.mp4'

videoCapture = cv2.VideoCapture(video_path)

def save_image(image,addr,num):
  address = addr + str(num)+ '.jpg'
  cv2.imwrite(address,image)

i=0
  
while True:
    success, frame = videoCapture.read()
    if success:
        i += 1
        if i % 30 == 0: # 选取间隔
            print('i = ', i)
            save_image(frame,'./output/image',i) # mkdir yourself!
    else:
        print('end')
        break

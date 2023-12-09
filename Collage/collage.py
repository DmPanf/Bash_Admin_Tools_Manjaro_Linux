# collage.py
from PIL import Image

# Загрузите четыре изображения (замените 'image1.jpg', 'image2.jpg', etc. на ваши файлы)
image1 = Image.open('image1.jpg')
image2 = Image.open('image2.jpg')
image3 = Image.open('image3.jpg')
image4 = Image.open('image4.jpg')

# Установите ширину белых линий
line_width = 10

# Вычислите общий размер нового изображения
total_width = image1.width + image2.width + line_width
total_height = image1.height + image3.height + line_width

# Создайте новое изображение с белым фоном
collage = Image.new('RGB', (total_width, total_height), 'white')

# Разместите изображения на коллаже
collage.paste(image1, (0, 0))
collage.paste(image2, (image1.width + line_width, 0))
collage.paste(image3, (0, image1.height + line_width))
collage.paste(image4, (image3.width + line_width, image1.height + line_width))

# Сохраните коллаж
collage.save('collage.jpg')

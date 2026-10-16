FROM nginx:1.25.3-alpine

WORKDIR /var/www/codesandbox

# यहाँ 'www' हटा दिया है ताकि आपके प्रोजेक्ट की सभी फाइलें सीधे कॉपी हो जाएं
COPY . ./

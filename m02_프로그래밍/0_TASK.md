# Task1_0425. 주어진 숫자 리스트에서 최소값과 최대값을 찾아 출력하세요.
numbers = [58, 45, 69, 19, 4, 87, 29, 13, 39, 15]

numbers.sort()
print('최소값:',numbers[0])

numbers.sort(reverse = True)
print('최대값:',numbers[0])

# teach # Task1_0425
min_value = min(numbers)
max_value = max(numbers)
print(min_value,max_value)
print('\n')
print('최소값:{}, 최대값:{}'.format(min_value,max_value))
print(f"최소값: {min_value}, 최대값: {max_value}")

min_value1 = numbers[0]
max_value1 = numbers[0]

min_value1 = numbers[0]
max_value1 = numbers[0]

for i in numbers:
    if i < min_value1:
        min_value = i
    if i > max_value1:
        max_value = i
print('\n')
print(f'최소값:{min_value1}\n최대값:{max_value1}')

# Task2_0425. 주어진 숫자 리스트의 모든 요소의 합계와 평균을 계산하고 출력하세요
numbers = [58, 45, 69, 19, 4, 87, 29, 13, 39, 15]
muti_numbers = sum(numbers)
cnt = len(numbers)
avg_numbers = muti_numbers / cnt

print('총합 :',muti_numbers)
print('평균 :',avg_numbers)


# Task3_0425. 주어진 리스트에서 특정 요소가 등장하는 모든 인덱스를 리스트로 만들어 출력하세요.
items = ['apple', 'banana', 'cherry', 'apple', 'cherry', 'apple']
search_items = []

for i in items:
    if 'apple' in i:
        search_items.append(i)

print(search_items)

# teach_Task3_0425
target = 'apple'
indexes = [index for index, value in enumerate(items) if value == target]
print(f"{target}의 모든 인덱스: {indexes}")

# enumerate() 내장함수 : for(반복문) 사용시 인덱스변수 대신 사용하는 *함수*
letters = ['A', 'B', 'C']
# for문 변수사용
for i in range(len(letters)):
    letter = letters[i]
    print(i, letter)
# for문 enumerate
for entry in enumerate(letters, start=1):
    print(entry)


# Task4_0425. 주어진 리스트에서 연속해서 반복되는 요소만 제거하고, 결과 리스트를 반환하세요. 단, 처음 등장하는 요소는 유지해야 합니다.
#예를 들어, ['a', 'a', 'b', 'c', 'c', 'c', 'd', 'e', 'e']가 입력되면, ['a', 'b', 'c', 'd', 'e']를 출력해야 합니다.

items = ['a', 'a', 'b', 'c', 'c', 'c', 'd', 'e', 'e']
result = []

for i in items:
    if i not in result:
        result.append(i)

print('최초 :',items)
print('결과 :',result)

# teach_Task4_0425
li = ['a', 'a', 'b', 'c', 'c', 'c', 'd', 'e', 'e']
result2 = [li[0]]
for i in li[1:]:
    if i != result2[-1]:
        result2.append(i)
print(result)

# teach_Tsk04(2)
def remove_consecutive_duplicates(items):
    #결과 리스트 초기화
    result = [items[0]]
    #이전 값과 비교하여 연속된 중복제거
    for i in items[1:]:
        if i != result[-1]:
            result.append(i)
    return result

items = ['a', 'a', 'b', 'c', 'c', 'c', 'd', 'e', 'e']
print(remove_consecutive_duplicates(items))




# Task5_0425 주어진 정수 리스트와 회전 횟수 k에 대해 리스트를 오른쪽으로 k만큼 회전시킨 결과를 반환하세요.
# k가 리스트의 길이보다 클 수 있으며, 이 경우 k를 리스트 길이로 나눈 나머지만큼 실제 회전시키면 됩니다.
# 예를 들어, [1, 2, 3, 4, 5]와 k=2가 주어지면, 결과는 [4, 5, 1, 2, 3]이 되어야 합니다.

print('종료키 : a')
def Right_movelist(move_list, k):
    if k == 0:
        print("잘못 입력하였습니다")
    else:

        return move_list[-k:] + move_list[:-k]

numbers = [58, 45, 69, 19, 4, 87, 29, 13, 39, 15]
print(numbers,'\n')

k = int(input('우측 회전값(k) 입력 : '))
print(Right_movelist(numbers,k),'\n\n')


def Left_movelist(move_list, k):
    if k == 0:
        print("잘못 입력하였습니다")
    else:
        return move_list[k:] + move_list[:k]

numbers = [58, 45, 69, 19, 4, 87, 29, 13, 39, 15]
print(numbers,'\n')

k = int(input('좌측 회전값(k) 입력 : '))
print(Left_movelist(numbers,k))

# teach_Task5_0425
def rotate_list(nums, k):
    if not nums:
        return nums
    #회전 횟수를 리스트 길이로 나눈 나머지로 계산
    k = k % len(nums)
    #리스트 끝부분을 앞으로, 앞부분을 끝으로 이동
    rotated = nums[-k:] + nums[:-k] # k=2 일 때, nums[-2:]=[4,5] + nums[:-2]=[1,2,3] = [4,5,1,2,3]
    return rotated
nums = [1,2,3,4,5,'a']
k = 2
print(rotate_list(nums,k))


def rotate_right_list(nums, k):
    if not nums:
        return nums
    #회전 횟수를 리스트 길이로 나눈 나머지로 계산
    k = k % len(nums)
    #리스트 끝부분을 앞으로, 앞부분을 끝으로 이동
    rotated = nums[k:] + nums[:k]
    return rotated
nums = [1,2,3,4,5,'a']
k = 2
print(rotate_right_list(nums, k))



# Task1_0426. 주어진 리스트에서 중복된 요소를 제외하고 고유한 요소의 개수를 세는 프로그램을 작성하세요.
data = [1, 2, 2, 3, 4, 4, 4, 5]

check = set(data)
print(f'해당 List상 고유한 요소 개수는 : {len(check)}개 입니다.')


# Task2_0426. 두 개의 리스트에서 공통으로 나타나는 요소들을 찾아 리스트로 반환하는 프로그램을 작성하세요.
#예시 입력: list1 = [1, 2, 3, 4, 5], list2 = [4, 5, 6, 7, 8]
#예시 출력: [4, 5]

list1 = [1,2,3,4,5]
list2 = [4,5,6,7,8]

set1 = set(list1)
set2 = set(list2)

print(f'두 개의 리스트 중 교집합 요소는 {list(set1&set2)} 입니다.')


# Task3_0426. 주어진 숫자 리스트에서 특정 값보다 큰 요소가 하나라도 존재하는지 검사하고, 그 결과를 불 값으로 반환하는 함수를 작성하세요.
def Check_MaxNum(a,b):
    max_value = max(a)
    if max_value > b:
        return True
    else:
        return False

numbers = [1, 2, 3, 10, 20]
threshold = 15

print(f'검사결과 : {Check_MaxNum(numbers, threshold)}')


# Task4_0426. 주어진 문자열이 특정 문자열을 포함하는지 확인하고 결과를 불 값으로 반환하는 함수를 작성하세요.
def Check_Inter(a,b):
    if a in b:
        return True
    else:
        return False

text = "hello world"
substring = "world"
print('확인결과 :{}'.format(Check_Inter(substring, text)))


# Task5_0426. 주어진 연도가 윤년인지 판별하는 함수를 작성하세요.
# 윤년은 다음의 조건을 만족해야 합니다:
# 4로 나누어 떨어진다.
# 100으로 나누어 떨어지지 않거나, 400으로 나누어 떨어지면 윤년이다.

def Check_Year(a,b):
    if a % b == 0:
        if a % b*25 != 0 or year % b*100 == 0:
            return True
        else:
            return False
    else:
        return False

year = 2020
print(f'윤년 확인 : {Check_Year(year,4)}')

# Task6_0426. Calculator 클래스를 작성하고 사칙연산을 수행하는
# 객체 4개를 작성하여 결과를 출력하세요.

class Calculator:
    def add(self,a,b,c,d):
        return a+b+c+d
    def sub(self,a,b,c,d):
        return a-b-c-d
    def mul(self,a,b,c,d):
        return a*b*c*d
    def div(self,a,b,c,d):
        return a/b/c/d

num1 = int(input('num1 입력:'))
num2 = int(input('num2 입력:'))
num3 = int(input('num3 입력:'))
num4 = int(input('num4 입력:'))

obj1 = Calculator()
print('더하기:',obj1.add(num1, num2, num3, num4))
print('빼기:',obj1.sub(num1, num2, num3, num4))
print('곱하기:',obj1.mul(num1, num2, num3, num4))
print('나누기:',obj1.div(num1, num2, num3, num4))

# Task7_0426. 다음 과제를 수행하세요.
# - 사용자로 부터 텍스트를 입력 받는다.
# - 문자을 단어 단위로 분리 : split()
# - 단어의 빈도수를 저장할 딕셔너리를 생성
# - 각 단어의 빈도 수를 계산(for 문 / if else문) : word = word.lower() 소문자변환
# - 결과 출력

# [ 예시 ]
# 문장을 입력하세요: I love apple. I love orange. Apple is tasty
#{'i': 2, 'love': 2, 'apple.': 1, 'orange.': 1, 'apple': 1, 'is': 1, 'tasty': 1}


str1 = input('문장을 입력하세요:')
word_list = str1.lower()
word_list = word_list.replace(".","")
word_list = word_list.split()
word_cnt = {}

for i in word_list:
    if i in word_cnt:
        word_cnt[i] += 1
    else:
        word_cnt[i] = 1

print(word_cnt)


#Task1_0429. input_str을 아래와 같이 단어로 분리하여 출력하세요.
#['Hello', 'world', 'How', 'are', 'you', 'today', 'I', 'am', 'fine', 'Thank', 'you', '']

input_str = "Hello, world! How are you today? I am fine. Thank you!"
word = input_str.replace('!','').replace(',', '').replace('?', '').replace('.', '').split()
print(word)

# teach.Task1_0429
import re

tokens = re.split('[ ,.?!]+', input_str)
print(tokens)


# Task2_0429. 십진수 122를 2진수, 8진수, 16진수로 변경하여 출력하세요.

num = 122

a = bin(num)
b = oct(num)
c = hex(num)

print('2진수:',a)
print('8진수:',b)
print('16진수:',c)


# teach.Task2_0429
decimal_number = 122
binary_number = bin(decimal_number)
print('2진수:',binary_number)

octal_number = oct(decimal_number)
print('8진수:',octal_number)

hexadecimal_number = hex(decimal_number)
print('16진수:',hexadecimal_number)



# Task3_0429. 두 수의 곱셈 결과를 계산하고, 그 결과에 10을 더하세요.

num1 = int(input('num1:'))
num2 = int(input('num2:'))

print(f'{num1} * {num2} = {num1*num2} (+ 10)\nresult : {num1*num2+10}')



# Task4_0429. 주어진 리스트에서 두 번째 요소를 삭제하고, 마지막에 새로운 요소 'Python'을 추가하세요.
#리스트: ['Java', 'C', 'JavaScript']

CL_list = ['Java', 'C', 'JavaScript']
print('최초:',CL_list)

del CL_list[1]
print('2번째 요소 삭제:',CL_list)

CL_list.append('Python')
print('마지막 요소 추가:',CL_list)

# teach.Task4_0429
# 요소삭제 : print(CL_list.pop(1))



# Task5_0429. 주어진 문자열에서 처음 세 글자와 마지막 세 글자를 연결하여 새로운 문자열을 만드세요.
#문자열: 'Incredible'

string = list('Incredible')
word_list1 = string[0:3]
word_list2 = string[-3:]
combine = word_list1 + word_list2

text = ''.join(combine)
print(text)
print(type(text))

# teach.Task5_0429

text = 'Incredible'
new_text = text[:3] + text[-3:]
print(new_text)



# Task6_0429. 사용자의 이름과 이메일을 딕셔너리로 저장하고, 이름을 입력받아 해당하는 이메일을 출력하세요.
#사용자 정보: 이름 - 'Alice', 이메일 - 'alice@example.com'

user_info = {'Alice':'alice@example.com', 'Tom':'tom12@example.com'}

Name = input('ID 입력 : ')

if Name == 'Alice':
    print(user_info['Alice'])
elif Name == 'Tom':
    print(user_info['Tom'])
else :
    print('사용자 정보 없음')

# teach.Task6_0429
d = {'Alice':'alice@example.com', 'Tom':'tom12@example.com'}
name = input('이름 입력 : ')
if name in d:
    print(d[name])
else:
    print("존재하지 않음")



# Task7_0429. 주어진 두 튜플에서 공통 요소만을 찾아 집합으로 만드세요.
#튜플: (1, 2, 3, 4, 5)와 (4, 5, 6, 7, 8)

tuple1 = (1, 2, 3, 4, 5)
tuple2 = (4, 5, 6, 7, 8)

set1 = set(tuple1)
set2 = set(tuple2)

check = set1 & set2

print(check)


# teach.Task7_0429
common_elements = set(tuple1) & set(tuple2)
print(common_elements)



# Task8_Challenge_0429. 다음 요구 사항을 충족하는 프로그램을 작성하세요:
#사용자로부터 이름, 나이, 좋아하는 색상을 입력받습니다.
#입력받은 정보를 딕셔너리로 저장하고, 모든 사용자 정보를 리스트에 저장합니다.
#이름이 'John'인 사용자의 정보만 출력하세요.
#전체 사용자의 평균 나이를 계산하고 출력하세요.
# =============================================================================
# 1. 사용자 데이터:
# - 이름: John
# - 나이: 28
# - 좋아하는 색상: Blue
# 2. 사용자 데이터:
# - 이름: Alice
# - 나이: 24
# - 좋아하는 색상: Red
# 3. 사용자 데이터:
# - 이름: Maria
# - 나이: 32
# - 좋아하는 색상: Green
# =============================================================================

userDict = {}
userList = ['이름', '나이', '좋아하는색']
msg = '1.사용자 추가\n2.정보 확인\n3.사용자 목록\n4.종료\n'

while True :
    choice = int(input(msg))

    if choice == 1:
        userName = input("사용자 이름 : ")
        if userName in userDict:
            print("!!사용자 이름 중복!!")
        else: #userDict[userName] = input() : userDict에 key&value 추가
            userDict[userName] = input("이름, 나이, 좋아하는색 입력\nex)Kim,35,Black\n").split(",")
            
    elif choice == 2:
        userName = input("확인할 사용자 이름 : ")
        if userName in userDict:
            print(userDict[userName])
        else :
            print('해당 사용자는 없습니다.')
            
    elif choice == 3:
        print(userDict)

    elif choice == 4:
        break
    
    else:
        print("잘못 입력하셨습니다")

total_age = sum(int(user_info[1]) for user_info in userDict.values()) 
average_age = total_age / len(userDict)  
print(f"사용자들의 평균 나이는 {average_age:.2f}살입니다.")

# teach.Task8_0429
users = []
for _ in range(3):
    name = input("이름 입력:")
    age = int(input("나이 입력:"))
    favorite_color = input("좋아하는 색:")

    user_info = {'name':name, 'age':age, 'favorite_color':favorite_color}
    users.append(user_info)
    
for user in users:
    if user['name'] == 'Jonh':
        print(f'Jonh\'s info:{user}')

total_age = sum(user['age'] for user in users)
average_age = total_age / len(users)
print(f'Average age of users:{average_age:.2f}')


# Task1_0430. 남녀 파트너 정해주기 프로그램(zip)
# 같은 수의 남녀 모임에서 파트너를 랜덤하게 정해주는 프로그램을 만들어 보세요.

from random import shuffle

male = ['철수','여포','로미오','이몽룡','온달']
female = ['영희','백설','줄리엣','춘향','초선']

shuffle(male); shuffle(female)
couples = zip(male,female)
print(list(zip(male, female)))

# teach.Task1_0430
for i, couple in enumerate(couples):
    print(f'커플{i+1}: {couple[0]}, {couple[1]}')

# Task2_0430. 대문자, 소문자, 숫자를 포함하는 8자리 랜덤 비밀번호를 생성하는 프로그램을 작성하세요.
import random
import string # 문자열 상수를 제공하는 모듈로, 여기서는 알파벳 문자,숫자 포함

num1 = str(123456789)
str1 = 'abcdefghijklmnopqrstuvwxyz'
str2 = str1.upper()
word = num1 + str1 + str2

password = random.sample(word, 8)
print('무작위 8자리 비밀번호:',''.join(password))

# teach.Task2_0430
import random
str1 = string.ascii_letters
print(str1)
numbers = string.digits
print(numbers)

characters = str1 + numbers
passwords = ''.join(random.choice(characters) for i in range(8))
print("랜덤 비밀번호 : ", passwords)

# if 대문자, 소문자, 숫자가 한번씩은 반드시 포함되야 하는 경우
upper = random.choice(string.ascii_uppercase)
lower = random.choice(string.ascii_lowercase)
digit = random.choice(string.digits)

characters = string.ascii_letters + string.digits
rest = ''.join(random.choice(characters) for i in range(5))
# 모든 요소를 하나의 문자열로 합치기
password = upper + lower + digit + rest
print(password)
password = ''.join(random.sample(password, len (password))) # 선택할 시퀸스, 요소
print('랜덤 비밀번호 : ',password)


# Task3_0430. 발표자 수를 랜덤하게 출력하는 프로그램을 작성하세요.
# (발표자 수 입력)
import random

kita = ['김성현','황강민','윤호준','류윤선','이상협','박지환','최환욱','서보선','김한결','김도현','김하준',
        '김도원','신현진','소지승','이범석','이현석','이명신','박윤경','이도헌','김홍준']

pick = int(input('발표자 수 입력 :'))

presenters = random.sample(kita, pick)

print(f'발표자 : {presenters}')

# Task4_0430. 사용자로부터 숫자를 입력받아 해당 숫자의 구구단을 
# 출력하는 프로그램을 작성하세요.
title = '구구단 프로그램'
num1 = input('1~9 사이 숫자 입력:')
result = 0
print('\n' + num1 + ' ' + '단')
num1 = int(num1)

for i in range(1,10):
    print(f'{num1}*{i} = {num1 * i}')
    

# if 한번에 출력
for i in range(2, 10):
    print(f"{' '*5}{i}단{' '*5}", end = '\t')
print()     # f-string내에서 { } 안에는 변수 뿐만 아니라 Python 표현식도 올 수 있음.

for i in range(2,10):
    print('='*12, end = '\t')
print()    

for i1 in range(1,10):
    for i2 in range(2,10):
        print(f"{i2} * {i1} = {i1 * i2}\t", end = '') 
    print()

# Task5_0430. 사용자로부터 숫자를 입력받아 해당 숫자의 팩토리얼을 계산하세요.
num = int(input('숫자입력:'))
result = 1

for i in range(1, num+1):
    result *= i
    
print(result)

# Task6_0430. 0부터 20까지의 숫자 중에서 짝수와 홀수를 분리하여
# 두 개의 리스트에 저장하세요.
numbers1 = []
numbers2 = []

for i in range(21):
    if i % 2 == 0 and i != 0:
        numbers1.append(i)
    elif i % 2 != 0 and i != 0:
        numbers2.append(i)
        
print(numbers1, numbers2)

# Task7_0430. 주어진 리스트에서 최대값을 찾아 출력하세요.
numbers = [34, 78, 2, 45, 99 ,23]

max_value = max(numbers)
print(max_value)

# teach.Task7_0430.
max = 0
for i in numbers:
    if i > max :
        max = i
print(max)

# Task8_0430.  1부터 10 사이의 임의의 숫자를 맞추는 게임을 만드세요.
# 사용자가 숫자를 맞출 때까지 입력을 계속 받으며, 정답을 맞추면 게임을 종료하세요.
import random
print('Up & Down 게임')
picknum = random.randint(1,10)

while True:
    choice = int(input('숫자를 맞추세요. \'1~10 사이 중 하나\''))
    if picknum > choice and choice < 11:
        print("Up!")
        
    elif picknum < choice and choice < 11:
        print("Down!")
    
    elif picknum == choice:
        print('정답!')
        break
    else:
        print('잘못 입력함!')


# Task9_0430. 태어난 연도를 입력받아 띠를 출력하는 프로그램을 작성하세요.
ani_year = ['쥐','소','호랑이','토끼','용','뱀','말','양','원숭이','닭','개','돼지']

while True:
    year = int(input('출생년도 입력(종료키:0) : '))
    index = (year - 1900) % 12
    animal = ani_year[index]
    
    if year == 0:
        break
    else:
        print(f'{year}년생은 {animal}띠입니다.')

# teach.Task9_0430.
# 0년 부터 시작할 경우(2024/12) = 8이므로 8번째 인덱스 값 원숭이로 list 순서 변경
x = ['원숭이','닭','개','돼지','쥐','소','호랑이','토끼','용','뱀','말','양']
y = int(input('출생년도 입력 : '))
print(f'{x[y%12]} 띠')


# Task10_0430. 아래 사항을 반영하여 커피 자판기 프로그램을 작성하세요.
# 시나리오 : 자판기 커피 재고 5잔, 커피 1잔 가격 300원, 재고 범위내에서 300원 이상 돈을 넣으면
#            거스름돈과 커피를 주고 그렇지 않으면 반환하며 재고가 소진되면 안내멘트 출력
# - 각 Case별 멘트 출력은 상황에 맞게 창작
# - while, if ~ elif ~ else 제어문을 사용하여 작성

def coffee_machine(money):
    price = 300 # 커피값
    coffee = 5 # 커피재고
    count = min(money // 300, coffee) # 커피잔수
    change = money - (count * price) # 거스름돈

    for i in range(count):
        if coffee > 0:
            change = money - (i+1) * price
            coffee -= 1
        else :
            print('커피재고 없음')
    print("커피 = %d잔, 잔돈 = %d원" %(i+1, change))

print('*커피 자판기*')
my_money = int(input('투입 금액 : '))
coffee_machine(my_money)

# teach.Task10_0430.
coffee_cnt = 5

while True:
    money = int(input('금액 투입 : '))
    if money == 300:
        print('1잔 나옴')
        coffee_cnt -= 1
    elif money > 300:
        want = int(input('잔수 입력 : '))
        money_want = want * 300
        if money < money_want:
            print('금액 부족')
        else:
            print(f'{want}잔 나옴, 잔돈 {money - money_want}원 받아가세요.')
        coffee_cnt -= want
    else:
        print('금액 부족, 투입금액 반환 (%d원)'%(money))
    if coffee_cnt == 0:
        print('커피 재고 없음')
        break


# Task1_0502. 짝수와 짝수를 입력하면 곱한 값을 출력하고 홀수와 홀수를 입력하면 덧셈 값을 출력하고 그외는 다시 입력하라는 메시지를 출력하세요.

num1 = int(input('정수 입력 : '))
num2 = int(input('정수 입력 : '))

mulNum = num1 * num2
sumNum = num1 + num2

if num1 % 2 == 0 and num2 % 2 == 0:
    print(f'{num1}*{num2} = {mulNum}')
elif num1 % 2 != 0 and num2 % 2 != 0:
    print(f'{num1}+{num2} = {sumNum}')
else:
    print('다시 입력하시오')


# Task2_0502. 현재 계절 구분 프로그램
# - 시나리오 : 3 ~ 5월은 봄, 6 ~ 8월은 여름, 9 ~ 11월은 가을,
#             12 ~ 2월은 겨울로 구분. 지금 계절을 알려주는 프로그램
# - 각 계절별 출력 멘트는 계절에 맞게 창작
# - if 조건문으로 datetime 모듈을 import해서 datetime.now 함수를 사용해서 작성

# import datetime
# import pytz

# now = datetime.datetime.now()
# now_month = now.month

# seasons = [('봄',[3, 4, 5]), ('여름',[6, 7, 8]),('가을',[9,10,11]),('겨울',[12,1,2])]

# for season, months in seasons:
#     if now_month in months:
#         print(f'현재 계절은 {season}입니다.')
#         break
# else:
#     print('날짜 오류')

#%% teach.Task2_0502.
from datetime import datetime
spring = [3, 4, 5]
summer = [6, 7, 8]
autumn = [9,10,11]
winter = [12,1,2]

today = datetime.now()
month = today.month

if month in spring:
    print("봄")
elif month in summer:
    print('여름')
elif month in summer:
    print('가을')
else:
    print('겨울')

# method.2
t = datetime.datetime.now()
print('현재 계절은?')
if t.month<12 and t.month >= 9:
    print('가을')
elif t.month<6 and t.month >= 3:
    print('봄')
elif t.month<9 and t.month >= 6:
    print('여름')
else:
    print('겨울')



# Task3_0502. 1부터 99까지 아래와 같이 2개의 수를 곱해서 가장 큰 수를 구하세요.
# `1*99, 2*98 ...99*1`

result = 0

for i1 in range(1,100):
    i2 = 100 - i1
    mul = i1 * i2
    if mul > result:
        result = mul

print('최대값',result)

#%% teach.Task3_0502.
max_value = 0
for i in range(1, 100):
    if max_value > (i*(100-i)):
        continue
    else:
        max_value = i*(100-i)
print(max_value)

# while문 사용
while n <= 100:
    a = n*(100-n)
    if a > result:
        result = a
        n += 1
    else:
        n += 1
        continue
print(result)

# 메소드 사용 예제
def findBiggestOne():
    result = 0
    for i in range(1,100):
        value = i * (100-i)
        if value > result:
            result = value
    return(result)
print(findBiggestOne())

# teach.메소드. 입력값 업속 출력값만 있는 형태의 사용자 함수
def findBiggestOne():
    biggestNum = 0
    for i,j in zip(range(1,100), range(99,0,-1)):
        if i*j > biggestNum:
            biggestNum = i*j
    return biggestNum
print(findBiggestOne())    


# Task4_0502. [    ]을 채워서 아래의 출력과 같이 출력하세요.
numbers = [1,2,3,4,5,6,7,8,9]
output = [[], [], []] # [[1,4,7],[2,5,8],[3,6,9]]

output = [[1,4,7],[2,5,8],[3,6,9]]
output = [numbers[0::3], numbers[1::3],numbers[2::3]]

#%% teach.Task4_0502.
numbers = [1,2,3,4,5,6,7,8,9]
output = [[],[],[]]

for num in numbers:
    if num % 3 == 1:
        output[0].append(num)
    elif num % 3 == 2:
        output[1].append(num)
    else :
        output[2].append(num)
print(output)

# method.2
for number in numbers:
    output[(number-1)%3].append(number)
print(output)



# Task5_0502. 주어진 리스트에서 중복된 요소를 제거하고,
# 남은 요소만을 포함하는 새 리스트를 반환합니다. 순서는 유지해야 합니다.

input_list = [1, 2, 2, 3, 4, 4, 4, 5, 6, 7, 7]

set1 = set(input_list)
set1 = list(set1)
print(set1)

# method.2
items = []
for i in input_list:
    if i not in items:
        items.append(i)
print(items)

#%% teach.Task5_0502.
for i in input_list:
    if input_list.count(i) > 1: #count함수 (중복요소 확인)
        input_list.remove(i) # 1개 초과 중복요소 제거
print(input_list)


# method (응용예제)
input_list = [1, 2, 6, 2, 3, 7, 4, 4, 5, 6, 7, 7]

def remove_dup(input_list):
  num = []
  for item in input_list:
    if item not in num:
      num.append(item)
  return num

result=remove_dup(input_list)
print(result)


# Task6_0502. 주어진 문자열을 모스 코드로 변환하는 함수를 작성하세요.
# 공백은 무시하고 알파벳만 변환하세요.
morse_code = {
        'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.',
        'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..',
        'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.',
        'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
        'Y': '-.--', 'Z': '--..'
    }
input_text = "Hello World"
result = ''
text_word = input_text.replace(' ','').upper()

for i in text_word:
    if i in morse_code:
         result += morse_code[i] + '`'
print(result)

# teach.Task6_0502.

for char in input_text:
    if char.upper() in morse_code:
        result += morse_code[char.upper()]
                # morse_code[key]
print(result)


# Task7_0502. 주어진 비대칭 m×n 매트릭스(2차원 리스트)에서, 모든 대각선 상의
# 합을 계산하는 함수를 작성하세요. 결과는 각 대각선의 합을 리스트로 반환해야 합니다.
# 반환값 : [1, 6, 15, 24, 20, 12]

input_matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
]
print(len(input_matrix))
print(len(input_matrix[0]))

def diagonal_sums(matrix):
    if not matrix:
        return []
    m, n = len(matrix), len(matrix[0])
    # 최대 가능한 대각선 수는 m + n - 1
    print(m,n)
    max_diagonals = m + n - 1
    result = [0] * max_diagonals

    # 모든 원소를 순회하면서 해당 대각선 인덱스에 값을 더함
    for i in range(m):
        for j in range(n):
            # 대각선 인덱스는 행 인덱스와 열 인덱스의 차의 절댓값
            diagonal_index = i + j
            result[diagonal_index] += matrix[i][j] # 인덱스 위치(i,j)

    return result

# 매트릭스 입력
input_matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
]

# 대각선 합 결과 출력
print(diagonal_sums(input_matrix))


# Task1_0503. 여러개의 음식을 동시에 주문할 수 있는 주문 시스템을 작성하세요.(구조 지향)
# global 사용
# logic : 메뉴선택 -> 수량선택 -> 세트여부 선택 -> 추가 주문여부결정


def orderMenu():
    menu = {1: 12000, 2: 8000, 3: 10000}
    total = 0
    while True:
        order = int(input('비빔밥 메뉴를 선택해 주세요 (1, 2, 3) : ')) #메뉴선택
        if order not in menu:
            print("잘못 입력 하였습니다.")
            continue
        order_cnt = int(input('주문 수량을 입력해 주세요: ')) #수량선택
        price = menu.get(order, 0) * order_cnt  # 가격계산
        set_order = input('세트로 주문을 하시겠습니까? 3,000원 추가.(y/n) : ') #세트여부
        if set_order == 'y':
            price += 3000 * order_cnt  #세트주문 가격계산
        total += price # 총금액 합산
        add = input('계속 주문하시겠습니까? (y/n): ')
        if add != 'y':
            break
    print(f"총 금액은 {total}원 입니다.")

print((
'''
    KITA 식당에 오신 것을 환영합니다
=====================================

          - 메  뉴 -
    1. 불고기 비빔밥 : 12,000원
    2. 야채 비빔밥 : 8,000원
    3. 전주 비빔밥 : 10,000원

    세트 주문시 : 3000원 추가
    (세트는 밥과 반찬이 추가됩니다.)

=====================================
'''
))
print(orderMenu())


#teach.Task1_0503.

menu_items = {'1':('불고기 비빔밥', 12000),
              '2':('야채 비빔밥', 8000),
              '3':('전주 비빔밥', 10000)}

set_price = 3000
orders = {}
price_total = 0

def display_menu():
    print("\n♣♣♣ KITA 식당에 오신 것을 환영합니다 ♣♣♣")
    print("========================================")
    print("           - 메뉴 -")
    for key, (name, price) in menu_items.items():
        print(f"  {key}. {name} : {price}원")
    print("\n  세트 주문시 : 3000원 추가 (세트는 밥과 반찬이 추가됩니다.)")
    print("========================================")
    
def display_order_summary():
    global price_total # 전역변수 price_total 사용 선언 (모든 함수 변수 공유)
    print('\n◆장바구니')
    price_total = 0
    for key, (name, price) in menu_items.items(): #딕셔너리 key,value 가져오기
        count = orders.get((key, False), 0) 
        #get함수 = 딕셔너리 key있으면 값 가져오기. 없으면 0
        count_set = orders.get((key, True), 0)
        print(f' {name} {count}개 : {count * price}원')
        print(f' {name} 세트 {count_set}개 : {count_set*(price + set_price)}')
        price_total += (count * price) + (count_set * (price + set_price))
    print(f' 총 금액 {price_total}원\n')
    
def add_order(menu_id, is_set):
    item_name, item_price = menu_items[menu_id]
    if is_set:
        item_price += set_price
    num = input(f"\n◆{item_name}{' 세트' if is_set else ''} 몇 개 주문하시겠습니까?\n")
    if num.isdigit() and int(num) > 0:
        orders[(menu_id, is_set)] = orders.get((menu_id, is_set), 0) + int(num)
        #        ↳   key          : ↳      value    + int(num)!추가주문!
        # 요약 : 딕셔너리 orders = {(menu_id, is_set):num(개수)} // is_set = true or false (세트 여부)
        print(f"\n{item_name}{' 세트' if is_set else ''} {num}개가 장바구니에 담겼습니다.\n")
    else:
        print('◆양수만 입력하세요◆')
        
def process_order():
    while True:
        msg = input('◆ 주문 하시겠습니까? (y or n) >>').strip().lower()
        if msg == 'y':
            while True:
                display_menu()
                display_order_summary()
                choice = input('◆주문할 메뉴를 선택해주세요. (1~3, \전체취소:0, 결제:5 >>').strip().lower()
                if choice in menu_items:
                    set_choice = input('\n◆3000원을 추가해 세트 주문하시겠습니까? \(y or n)\n').strip().lower()
                    if set_choice in ['y', 'n']:
                        add_order(choice, set_choice == 'y')
                    else:
                        print('◆잘못된 선택입니다. (y or n)')
                elif choice == '0':
                    orders.clear()
                    print('\n모든 주문이 취소되었습니다.')
                elif choice == '5':
                    if price_total > 0:
                        print(f'◆주문하려면 결제해주세요. 결제금액은 {price_total}원 입니다.\n')
                        input('결제를 완료하려면 아무 키나 누르세요..')
                        print(f'\n총 금액 {price_total}원이 결제되었습니다. 감사합니다')
                        orders.clear()
                        break
                else:
                    print('◆잘못 입력하였습니다')
            else :
                print('감사합니다')
                break
            
if __name__ == "__main__":
    process_order()



# Task2_0503. 내장함수 5개를 활용해서 사용자 함수로 간단한 프로그램을 만드세요.

# [예시] 문서관리 프로그램
# len() - 문자열의 길이를 계산합니다.\
# input() - 사용자로부터 입력을 받습니다.\
# print() - 결과를 출력합니다.\
# sum() - 주어진 조건에 따라 특정 개수를 계산합니다.\
# Counter (from collections) - 문자의 빈도수를 계산합니다.\

# 비밀번호 암호화/복호화 프로그램
# input() , len() , ord() , chr() , type()

be_pw = input('비밀번호 생성 (10자리 이상) : ')
af_pw = ''
re_pw = ''

if len(be_pw) >= 10:
    for i in be_pw:
        af_pw += chr(ord(i)*5)
    print(f'기존 비밀번호 : {be_pw}')
    print(f'보안화 비밀번호 : {af_pw}')
else :
    print('오류! 10자리 미만')

if len(af_pw) >= 10 :
    for i2 in af_pw:
        re_pw += chr(ord(i2)//5)
    print(f'복호화 비밀번호 : {re_pw}')
else :
    print('오류! 10자리 미만')

print(type(af_pw))
print(type(re_pw))


#teach.Task2_0503
def string_statistics(user_input):
    #문자열 길이 변환
    length = len(user_input)

    #가장 자주 등장하는 문자 찾기
    from collections import Counter
    frequency = Counter(user_input)
    most_common = frequency.most_common(1)[0][0]

    #숫자 개수 세기
    num_count = sum(c.isdigit() for c in user_input)

    #대문자 개수 세기
    uppercase_count = sum(c.isupper() for  c in user_input)

    #소문자 개수 세기
    lowercase_count = sum(c.islower() for  c in user_input)    

    #결과 출력
    print(f'입력된 문자열의 길이: {length}')
    print(f'가장 자주 등장하는 문자: {most_common}')
    print(f'숫자의 개수: {num_count}')
    print(f'대문자 개수: {uppercase_count}')
    print(f'소문자 개수: {lowercase_count}')

user_input = input('문자열 입력:')
string_statistics(user_input)


# Task3_0503. 외장함수 3개 이상 활용해서 간단한 프로그램을 만드세요
from datetime import datetime
import random
import time

now = datetime.now()
loto_Num = [n for n in range(1, 46)]
jackpot_Num = []

for i in range(1, 7):
    random.shuffle(loto_Num)
    pick = loto_Num.pop()
    print(f'나왔습니다, {i}번째 당첨번호는 {pick}입니다.')
    jackpot_Num.append(pick)
    time.sleep(1)

jackpot_Num.sort()

print(f'{now.year}년도 {now.month}월, {now.day}일자\n로또 당첨 번호는 {jackpot_Num} 입니다.')


#teach.Task3_0503

import os
import datetime
import shutil

def daily_scheduler():
    #현재 날씨와 시간을 가져온다
    today = datetime.datetime.now()
    date_string = today.strftime('%Y-%m-%d %H:%M:%S')
    print(f'오늘의 날짜와 시간: {date_string}')
    #작업 파일의 이름을 정한다.
    filename = f"tasks_{today.strftime('%Y%m%d')}.txt"
    #파일이 이미 존재하는지 확인
    if os.path.exists(filename):
        print(f"'{filename}' 파일이 이미 존재합니다. 백업을 생성합니다")
        # 백업 파일 생성
        shutil.copy(filename, filename + '.bak')
    else :
        print(f"'{filename}' 파일이 존재하지 않습니다. 새로운 파일을 생성합니다.")

    #사용자로부터 오늘의 주요 작업을 입력받기
    task = input('오늘의 주요 작업을 입력하세요: ')
    #작업 내용을 파일에 저장합니다.
    with open(filename,'a') as file:
        file.write(f"{date_string}: {task}\n")
    print(f"'{filename}' 파일에 작업이 저장되었습니다.")
if __name__ == "__main__":
    daily_scheduler()



# Task4_0503. 리스트를 작성하고 람다 함수를 이용해서 한번에 함수를 적용하여 결과값을 출력하세요.
# 내장함수 map(f,iterable)
# 함수(f)와 반복가능한(iterable)자료형 입력으로 받는다.
# map은 입력받은 자료형의 각 요소를 함수 f가 수행한 결과를 묶어서 돌려준다.

numList = []

for i in range(1,6):
    numList.append((i))

squared_numList = map(lambda f : f * f, numList)
sum_numList = map(lambda f : f + f, numList)
filtered_numList = filter(lambda f : f % 2 == 0, numList)

print(list(squared_numList))
print(list(sum_numList))
print(list(filtered_numList))



# Task5_0503. 외부 라리브러리를 임포트해서 간단한 프로그램을 만드세요.
# ===========================예시==============================================
# from bs4 import BeautifulSoup
# html_doc = "<html><head><title>Hello World</title></head></html>"
# soup = BeautifulSoup(html_doc, 'html.parser')
# print(soup.title.text)
# =============================================================================

#teach.Task5_0503.
import requests
from bs4 import BeautifulSoup

def fetch_website_content(url):
    # URL에서 데이터를 가져온다
    response = requests.get(url)
    if response.status_code == 200:
    # HTML 내용을 객체로 패싱한다.
        soup = BeautifulSoup(response.text, 'html.parser')


    #예제 : 페이지 타이틀을 출력합니다.
        print("Page Title:", soup.title.string if soup.title else "No title found")
    else:
        print("Failed to  retrieve the webpage")
        print("Stauts code:", response.status_code)
if __name__=="__main__":
    url = input("저장하고 싶은 웹사이트의 URL을 입력하세요.:")
    fetch_website_content(url)

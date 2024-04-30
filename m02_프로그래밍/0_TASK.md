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





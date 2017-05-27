from scaner import Scan
from inc_m import *
print('input string:')
input_string = input()
scan = Scan(input_string)
# scan = Scan()
scan.check()
# example_str = 'switch (nday) {case 1: case 2: case 3: case 4: case 5: a=b; break; case 6: switch (j) { case 7: a = d; case 8: a=h; } case 7: a=0; }'
tmp = scan.result
err = 0
i = 0

if scan.result and check_braces(tmp):
    current_length = len(tmp)
    # print(current_length)
    # print(tmp)
    tmp = switch_check(tmp)
    big_flag = True
    # print(tmp)
    while big_flag and len(tmp) > 0:
        start_length = len(tmp)
        try:
            # print(start_length)
            tmp = switch_check(tmp)
            # print('switch_check')
            # print(len(tmp))
            # print(tmp)
            # print('case_check')
            tmp = case_check(tmp)
            # print(len(tmp))
            # print(tmp)
            # print('identifier_check')
            tmp = identifier_check(tmp)
            # print(len(tmp))
            # print(tmp)
            # print('break_check')
            tmp = break_check(tmp)
            # print(len(tmp))
            # print(tmp)
            if start_length == len(tmp):
                big_flag = False
        except IndexError:
            if start_length == len(tmp):
                big_flag = False
            elif current_length != len(tmp) and len(tmp) == 0:
                print('correct')
                scan.output()

    print(end_check(tmp))
else:
    print('incorrect expression')






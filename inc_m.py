def check_braces(check_list):
    opened = 0
    closed = 0
    for item in check_list:
        if item == "{":
            opened += 1
        elif item == "}":
            closed += 1
    if opened == closed:
        flag = True
    else:
        flag = False
    return flag


def switch_check(check_list):
    if check_list[0] == 'switch' and check_list[1] == '(' and check_list[2] == 'id' and check_list[3] == ')':
        check_list = check_list[4:]
    if check_list[0] == '{' and check_list[1] == 'case' and check_list[2] == 'const' and check_list[3] == ':':
        check_list = check_list[4:]
    return check_list


def case_check(check_list):
    if check_list[0] == 'case' and check_list[1] == 'const' and check_list[2] == ':':
        check_list = check_list[3:]
    if check_list[0] == '}':
        check_list = check_list[1:]
    return check_list


def identifier_check(check_list):
    if check_list[0] == 'id' and check_list[1] == '=' and check_list[2] == 'id' and check_list[3] == ';':
        check_list = check_list[4:]
    if check_list[0] == '}':
        check_list = check_list[1:]
    return check_list


def break_check(check_list):
    if check_list[0] == 'break' and check_list[1] == ';':
        check_list = check_list[2:]
    if check_list[0] == '}':
        check_list = check_list[1:]
    return check_list


def end_check(check_list):
    if len(set(check_list)) == 1 and '}' in set(check_list) or len(check_list) == 0:
        flag = True
    else:
        flag = False
    return flag

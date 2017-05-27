import re


class Scan:

    def __init__(self, check_str='switch (nday) {case 1: g=hh; case 3: case 4: case 5:'
                                 ' a=b; break; case 6: switch (j) { case 7: a = d; case 8: a=h; }'
                                 ' case 7: a=0; }'):
        self.example_str = check_str.lower()
        self.example_str = re.sub('\s+', ' ', self.example_str)
        self.err_count = 0
        self.result_list = []
        self.result = []

    def check(self):
        temp_list = self.example_str.strip().replace('  ', ' ').split(' ')

        for item in temp_list:
            if item == 'switch' or item == 'case' or item == 'break' or item == '{' or item == '}' or item == ';' or item == ':' or item == '=':
                self.result_list.append(item)
                self.result.append(item)
            elif ';' in item:
                if item[-1] == ';':
                    if '=' in item:
                        self.result_list.append(item[:item.index('=')])
                        self.result_list.append('=')
                        self.result_list.append(item[item.index('=') + 1:-1])
                        self.result_list.append(';')
                        self.result.append('id')
                        self.result.append('=')
                        self.result.append('id')
                        self.result.append(';')
                    else:
                        self.result_list.append(item[:-1])
                        self.result_list.append(';')
                        if 'break' in item:
                            self.result.append('break')
                        else:
                            self.result.append('id')
                        self.result.append(';')
                else:
                    self.err_count += 1
            elif item.isalnum() and item[0].isalpha():
                self.result_list.append(item)
                self.result.append('id')
            elif '{' in item:
                if item[0] == '{':
                    if item[1:] == 'case':
                        self.result_list.append('{')
                        self.result.append('{')
                        self.result_list.append(item[1:])
                        self.result.append('case')
                    else:
                        self.err_count += 1
            elif '}' in item:
                if item[-1] == '}':
                    if item[:-1] == 'case':
                        self.result_list.append(item[:-1])
                        self.result.append('case')
                        self.result_list.append('}')
                        self.result.append('}')
                    else:
                        self.err_count += 1
                else:
                    self.err_count += 1
            elif ':' in item:
                if item[-1] == ':':
                    self.result_list.append(item[:-1])
                    self.result_list.append(':')
                    if item[:-1].isdigit():
                        self.result.append('const')
                    else:
                        self.result.append('id')
                    self.result_list.append(':')
                    self.result.append(':')
                else:
                    self.err_count += 1
            elif '=' in item:
                if '=' != item[0] or '=' != item[-1] and item.index('=') == item.rindex('='):
                    self.result_list.append(item[:item.index('=')])
                    self.result.append('id')
                    self.result_list.append('=')
                    self.result.append('=')
                    self.result_list.append(item[item.index('=') + 1:])
                    self.result.append('id')
                else:
                    self.err_count += 1
            elif '(' in item and ')' in item:
                if item[0] == '(' and item[-1] == ')' and item[1].isalpha() and item[1:-1].isalnum():
                    self.result_list.append('(')
                    self.result.append('(')
                    self.result_list.append(item[1:-1])
                    self.result.append('id')
                    self.result_list.append(')')
                    self.result.append(')')
            else:
                self.err_count += 1

    def output(self):
        if self.err_count == 0 and 'case' in self.result:
            print(self.result_list)
            print(self.result)
            print('correct')
        else:
            print('incorrect expression')
        self.result = False

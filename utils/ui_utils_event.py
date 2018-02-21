from Tkinter import Event
from Tkinter import Frame as _tkframe


keypress = {'ctrl-c': {'char': '\x03', 
                  'keysym_num': 99, 
                  'delta': 524291, 
                  'keysym': 'c', 
                  'type': '2'}, 
            'Right': {'char': '\xef\x9c\x83', 
                      'keysym_num': 65363, 
                      'delta': 8189699, 
                      'keysym': 'Right', 
                      'type': '2'}, 
            'Up': {'char': '\xef\x9c\x80', 
                   'keysym_num': 65362, 
                   'delta': 8320768, 
                   'keysym': 'Up', 
                   'type': '2'}, 
            'Down': {'char': '\xef\x9c\x81', 
                     'keysym_num': 65364, 
                     'delta': 8255233, 
                     'keysym': 'Down', 
                     'type': '2'}, 
            'ctrl-s': {'char': '\x13', 
                  'keysym_num': 115, 
                  'delta': 65555, 
                  'keysym': 's', 
                  'type': '2'}, 
            'ctrl-v': {'char': '\x16', 
                  'keysym_num': 118, 
                  'delta': 589846, 
                  'keysym': 'v', 
                  'type': '2'}, 
            'ctrl-x': {'char': '\x18', 
                  'keysym_num': 120, 
                  'delta': 458776, 
                  'keysym': 'x', 
                  'type': '2'}, 
            'Left': {'char': 
                     '\xef\x9c\x82', 
                     'keysym_num': 65361, 
                     'delta': 8124162, 
                     'keysym': 'Left', 
                     'type': '2'},
            'ctrl-r': {'char': '\x12', 
                       'keysym_num': 114, 
                       'delta': 983058, 
                       'keysym': 'r', 
                       'type': '2'},
            'ctrl-R': {'char': '\x12', 
                  'keysym_num': 82, 
                  'delta': 983058, 
                  'keysym': 'R', 
                  'type': '2'},
            'ctrl-i': {'char': '\t', 
                       'keysym_num': 105, 
                       'delta': 2228233, 
                       'keysym': 'i', 
                       'type': '2'}
            }



class MyEvent(Event):
    def __init__(self,char,delta, keysym, keysym_num,
                 type,parent):
        self.char = char
        self.keysym = keysym
        self.keysym_num = keysym_num
        self.type = type
        self.widget = parent
        self.delta = delta
        self.keycode = keysym_num

def get_event(keysym,name,x,y,type='9'):
    
    # type of 9 is focus in
    # type of 10 is focus out
    #.4336597112.4336608032.4336608104.entrygrid,1,2
    
    parent_id = ".foo.foo.foo." + name + "," + str(x) + "," + str(y)
    
    event = MyEvent(keypress[keysym]['char'],
                    keypress[keysym]['delta'],
                    keypress[keysym]['keysym'],
                    keypress[keysym]['keysym_num'],
                    type,
                    parent_id)
    
    return(event)

    
def add_events(parent):
    for keysym in keypress.keys():
        keypress[keysym]['event'] = MyEvent(keypress[keysym]['char'],
                                            keypress[keysym]['delta'],
                                            keypress[keysym]['keysym'],
                                            keypress[keysym]['keysym_num'],
                                            keypress[keysym]['type'],
                                            parent)
    
    return(keypress)
                                            
                                            
if __name__ == '__main__':
    add_events(_tkframe())
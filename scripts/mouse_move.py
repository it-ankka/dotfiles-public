#!/usr/bin/python3
import time
from pynput.mouse import Controller, Listener;

mouse = Controller();

secs = 10;

moved = False;


def on_move(x,y):
    on_event();

def on_click(x,y,button,pressed):
    on_event();

def on_scroll(x,y,dx,dy):
    on_event();

def on_event():
    global moved ;
    moved = True;

mouse_listener = Listener(
    on_move=on_move, 
    on_click=on_click, 
    on_scroll=on_scroll)

mouse_listener.start();

print("Starting")

def wait(length):
    for i in range(length):
        if moved:
            break;
        print(f"{length - i}s");
        time.sleep(1);

def wiggle():
    mouse.move(-5, 0);
    time.sleep(0.05);
    mouse.move(10, 0);
    time.sleep(0.05);
    mouse.move(-5, 0);
    time.sleep(0.1);

def mouse_move():
    global moved;
    if not moved: 
        print(f"Moving mouse");
        wiggle();
    moved = False;
    wait(secs);

try: 
    while True:
        mouse_move()
except KeyboardInterrupt:
    print("Exiting...")

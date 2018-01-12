import sys
import torch
import torch.cuda
import torch.nn as nn
from torch.autograd import Variable
import torch.nn.functional as F
import matplotlib.pyplot as plt
import random
import numpy as np

file=open("train.csv","r",encoding='UTF-8')
question_array=[]

question_array=file.readlines()

del question_array[0]

for i in range(len(question_array)):
    question_array[i]=question_array[i].split(',')
    question_array[i][-1].replace("\n","")

for i in range(len(question_array)):
    for j in range(len(question_array[i])):
        question_array[i][j]=float(question_array[i][j])
        
print(question_array[121])

file.close()

x_values = question_array
x_train = np.array(x_values, dtype=np.float32)
x_train = x_train.reshape(-1, 8)


class LR(nn.Module):
        def __init__(self):
                super(LR, self).__init__()
                self.hidden1 = nn.Linear(8, 16)
                self.hidden2 = nn.Linear(16, 8)
                self.hidden3 = nn.Linear(8, 4)
                self.hidden4 = nn.Linear(4, 1)
        
        def forward(self, x):                
                x = F.relu(self.hidden1(x))
                x = F.relu(self.hidden2(x))
                x = F.relu(self.hidden3(x))
                out  = F.relu(self.hidden4(x))
                return out

model = LR()

# load the model
model.load_state_dict(torch.load("nonlinear_model.pkl"))

# convert to variables
x = Variable(torch.from_numpy(x_train))
prediction = model(x)

out = open("./ans_survived.csv", "w")
for y_value in prediction:
    print("y_value: %.8f" %(y_value.data[0]))
    out.write("%.8f" %(y_value.data[0]))
    out.write("\n")

import sys
import torch
import torch.cuda
import torch.nn as nn
from torch.autograd import Variable
import torch.nn.functional as F
import matplotlib.pyplot as plt
import random
import numpy as np

file=open("titanic.csv","r",encoding='UTF-8')
data_array=[]
ans_array=[]

data_array=file.readlines()

del data_array[0]

for i in range(len(data_array)):
        data_array[i]=data_array[i].split(',')

for i in range(len(data_array)):
        ans_array.append(data_array[i][-1])
        del data_array[i][-1]
        for j in range(len(data_array[i])):
                data_array[i][j]=float(data_array[i][j])
        
for i in range(len(ans_array)):
        ans_array[i].replace("\n","")
        ans_array[i]=float(ans_array[i])
        
file.close()

x_values = data_array
x_train = np.array(x_values, dtype=np.float32)
x_train = x_train.reshape(-1, 8)
y_values = ans_array
y_train = np.array(y_values, dtype=np.float32)
y_train = y_train.reshape(-1, 1)

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
loss_func = nn.MSELoss()
learning_rate = 0.01
optimizer = torch.optim.SGD(model.parameters(), lr=learning_rate)
plt.ion()
last_loss=100
epochs = 150000

for epoch in range(epochs):
    #epoch += 1

    # convert to variables
    x = Variable(torch.from_numpy(x_train))
    y = Variable(torch.from_numpy(y_train))

    # clear gradient w.r.t. parameters
    optimizer.zero_grad()
    # forward to get output
    prediction = model(x)

    # calculate loss
    loss = loss_func(prediction, y)


    if loss.data.sum() >last_loss:
        learning_rate/=2
        print("epoch %d, loss %.8f, learning_rate %.8f" % (epoch, loss.data[0], learning_rate))
        if learning_rate <0.00001:
            learning_rate=0.00001
    else:
        learning_rate*=2
        if learning_rate>2000:
            learning_rate=2000
    # backward to get gradient
    loss.backward()

    # update parameters
    optimizer.step()
    if epoch % 5 == 0:
    # plot and show learning process
        print("epoch %d, loss %.8f, learning_rate %.8f" % (epoch, loss.data[0], learning_rate))
        '''
        plt.cla()
        plt.scatter(x.data.numpy(), y.data.numpy())
        plt.plot(x.data.numpy(), prediction.data.numpy(), 'r-', lw=3)
        plt.text(0.5, 0, 'Step:%d Loss=%.4f' % (epoch, loss.data[0]), fontdict={'size': 20, 'color':  'red'})
        plt.pause(0.1)
        '''
    last_loss=loss.data.sum()
    last_paraneters=model.parameters()
    #last_paraneters = Variable( last_paraneters, requires_grad=True)

plt.ioff()
plt.show()

# save the model
save_model = True
if save_model == True:
    torch.save(model.state_dict(), "nonlinear_model.pkl")

# load the model
load_model = False
if load_model is True:
    model.load_state_dict(torch.load("nonlinear_model.pkl"))
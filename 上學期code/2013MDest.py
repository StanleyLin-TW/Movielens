import plotly.plotly as py
import plotly.graph_objs as go
import numpy as np
import csv
import time
from datetime import datetime
import itertools
i=0
f = open('2013M_data.csv', 'r')
f4=open('2013MDestination.txt','w')
for row in csv.DictReader(f):
	i=i+1
	print(i)
	s2=row["DEST"]
	f4.write(s2)
	f4.write("\n")

	


'''
# Create a trace
trace = go.Scatter(
    x = random_x,
    y = random_y
)

data = [trace]

py.iplot(data, filename='basic-line')
'''
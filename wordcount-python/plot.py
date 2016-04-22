import plotly.plotly as py
import plotly.graph_objs as go
# Sign in to plotly
py.sign_in('XXX', 'XXX') # Replace the username, and API key with your credentials.

# read data which is going to be plottet from file
with open("plot-data.txt") as f:
    content = f.readlines()

xlist = []
ylist = []

# keep the total count for calculating relative values
count = int(content.pop(0).split()[1])

for item in content:
    xlist.append(item.split()[0])
    ylist.append(int(item.split()[1]))

def relative(value): return (100*value)/count

ylist = map(relative, ylist)

# Create a simple chart..
trace = go.Bar(x=xlist, y=ylist)
data = [trace]
layout = go.Layout(
  width=800,
  height=640,
  yaxis=dict(
    range=[0, 100],
    title='Occurences in Percent'
  )
)

fig = go.Figure(data=data, layout=layout)

py.image.save_as(fig, filename='a-simple-plot.png')


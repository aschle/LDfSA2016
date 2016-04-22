import plotly.plotly as py
import plotly.graph_objs as go
# Sign in to plotly
py.sign_in('XXX', 'XXX') # Replace the username, and API key with your credentials.

# read data which is going to be plottet from file
with open("plot-data-abc.txt") as f:
    content = f.readlines()

xlist = []
ylist = []

summe = 0;
max = 0;

for item in content:
    xlist.append(item.split()[0])
    ylist.append(int(item.split()[1]))
    summe = summe + int(item.split()[1])
    if max < int(item.split()[1]):
      max = int(item.split()[1]);

def relative(value): return (100*value)/summe

ylist = map(relative, ylist)

# Create a simple chart..
trace = go.Bar(
  x=ylist,
  y=xlist,
  orientation = 'h',)
data = [trace]
layout = go.Layout(
  width=800 ,
  height=1200,
  xaxis=dict(
    range=[0, 100*max/summe],
    title='Occurences in Percent',
    titlefont=dict(
        size=18,
        color='#7f7f7f'
    )),
  yaxis=dict(
        title='Characters',
        titlefont=dict(
            size=18,
            color='#7f7f7f'
        )
  )
)

fig = go.Figure(data=data, layout=layout)

py.image.save_as(fig, filename='a-simple-plot-abc.png')


with open('cdc.txt') as f:
    row = {}
    for line in f.readlines():
        line = line.replace('D ','e')
        line = line.replace('D','e')
        line = line.split()
        if line[0] =='KNOT': continue
        if len(line) > 5:
            row['sex'] = line[5]
            row['age'] = line[6]
            row['percent'] = line[7]
            row['chart'] = line[8]
        row['x'] = int(float(line[0]))
        row['a'] = line[1]
        row['b1'] = line[2]
        row['b2'] = line[3]
        row['b3'] = line[4]
        print "insert into common.lu_growth_chart (sex,age,percent,chart,x,a,b1,b2,b3) values ('%(sex)s',%(age)s,%(percent)s,%(chart)s,%(x)s,%(a)s,%(b1)s,%(b2)s,%(b3)s);" % row


#!/usr/bin/python

import sys
import string

# check the usage
if len(sys.argv) != 3 :
    sys.stderr.write( "Usage: %s template solution\n" % sys.argv[0] )
    sys.exit(0)
    
# open the two data files
try:
    template = open( sys.argv[1], "r" )
except:
    sys.stderr.write( "Error:  could not open <%s>\n" % sys.argv[1] )
    sys.exit(0)
try:
    solution = open( sys.argv[2], "r" )
except:
    sys.stderr.write( "Error:  could not open <%s>\n" % sys.argv[2] )
    sys.exit(0)
    
correct = 0
wrong = 0
for line1 in template.readlines() :
    line2 = solution.readline()
    for indx in range(len(line1)) :
        if not line1[indx] in string.digits : continue
        if line1[indx] == line2[indx] :
            correct = correct + 1
        else :
            wrong = wrong + 1

total = correct + wrong;
print ("--------------------")
print ("correct: %5d(%5.1f)" % (correct, 100.0 * correct/float(total))) 
print ("wrong:   %5d(%5.1f)" % (wrong, 100.0 * wrong/float(total)))
print ("--------------------")
print ("total:   %5d(%5.1f)" % (total, 100.0))

    
    
template.close()
solution.close()

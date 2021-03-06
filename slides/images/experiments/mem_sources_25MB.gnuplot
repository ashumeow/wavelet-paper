set terminal postscript eps enhanced color "Helvetica" 16
set output "generated/experiments/mem_sources_25MB.eps"

set key left top
#set size square 0.3,0.3

set lmargin 0
set rmargin 0
#set xlabel "Arity"
set ylabel "Size\nCoefficient"
set ylabel rotate by 0


set xrange [0:5]
set xtics ("2" 1, "4" 2, "8" 3, "16" 4)
set yrange [0:10]
set ytics 1
set grid noxtics ytics
set border 3
set xtics nomirror
set ytics nomirror

set style data boxes
set style fill solid 0.7
set style fill noborder
set boxwidth 0.7

# COLOURS
table = "#9EBCBD"
tree  = "#485C58"
base  = "#362E31"

# struct:
# 0 - simple
# 1 - M-SDArray
# 2 - AB-RRR
# 3 - M-01RRR
# 4 - FC-RRR

# dna, dblp.xml, english, english.ints, sources, proteins
type = "sources"
# 25, 50, 75
size = 25
file = "images/experiments/data/".type.".".size."MB"


set size 1.1,1.2
set origin -0.18,-0.15
set xlabel "Arity"
set xlabel offset 19,-1
set multiplot layout 1,4

# get baseline
set table "temp"
plot [-1:1][0:50] file i 4 u 0:($0==0?(baseline=((($3 + \
                                $4)/(1024*1024))/size)):0)
unset table
base(x) = baseline

set bmarg 0

set title "Uncompressed WT"
struct = 0
plot file i struct u \
	(log($1)/log(2)):((($3 + $4)/(1024*1024))/size) \
	title "RRR Table" lc rgb table, \
 	"" i struct u (log($1)/log(2)):(($3/(1024*1024))/size) lc rgb tree \
	title "Wavelet Tree", base(x) title "Claude RRR" lc rgb base lw 2 lt 2

unset ylabel
unset xlabel
unset key
set lmargin 0
set border 1
set tic scale 0
set format y ""

#set title "multi-sdarray"
#struct = 1
#plot file i struct u \
#	(log($1)/log(2)):((($3 + $4)/(1024*1024))/size) \
#	title "RRR Table" lc rgb table, \
# 	"" i struct u (log($1)/log(2)):(($3/(1024*1024))/size) lc rgb tree \
#	title "Wavelet Tree", base(x) title "Claude RRR" lc rgb base lw 2 lt 2

set title "Generalised RRR"
struct = 2
plot file i struct u \
	(log($1)/log(2)):((($3 + $4)/(1024*1024))/size) \
	title "RRR Table" lc rgb table, \
 	"" i struct u (log($1)/log(2)):(($3/(1024*1024))/size) lc rgb tree \
	title "Wavelet Tree", base(x) title "Claude RRR" lc rgb base lw 2 lt 2

set title "Multi-Binary RRR"
struct = 3
plot file i struct u \
	(log($1)/log(2)):((($3 + $4)/(1024*1024))/size) \
	title "RRR Table" lc rgb table, \
 	"" i struct u (log($1)/log(2)):(($3/(1024*1024))/size) lc rgb tree \
	title "Wavelet Tree", base(x) title "Claude RRR" lc rgb base lw 2 lt 2

unset multiplot

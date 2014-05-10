rm res*
p='10'
m='15'
num=100
lambda=.00001
K=3
boundl=750
boundp=250
echo $p > instances # p
echo $m >>instances # m
echo $K >>instances # K
echo $lambda>>instances #lambda-com
echo $num >>instances # number of instances
echo $boundl >>instances # bound on latency
./creer>variables
cp variables variables2
for boundp in `seq 100 200 `; do #bound on period
  for boundl in `seq 200 300`; do #bound on latence
    rm reso*
    rm resg*
    echo $p > instances # p
    echo $m >>instances # m
    echo $K >>instances # K
    echo $lambda>>instances #lambda-com
    echo $num >>instances # number of instances
    echo $boundl >>instances # bound on latency
    echo $boundp >>instances #bound on period
    echo -n $boundp' ' >>results
    echo -n $boundl' ' >>results
    cp  variables2 variables
    i=`cat variables|wc -l `
    while [ $i -ge 1 ];do
      echo "debut greedy $i"
      ./greedys>>resgready
        echo 'new test'>>resopt2
        rm test.log
        ./constr>test.lp
        cat test.cmd|cplex  2> /dev/null>/dev/null
        cat test.log|grep 'All other variables'>>resopt2
        cat test.log|grep rel >>resopt2
      i=$(($i- 2*$m - 2*$p))
      tail -n $i variables>variable
      cat variable>variables
    done
    echo "done"
    echo 'debut analyze'
    ./analyze >>results
  done
done

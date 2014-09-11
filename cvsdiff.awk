# awk script for diffing the last two versions of a file. 
# for monitoring changes in CVS.
BEGIN {
    i = 0;
    rev[0] = "";
    rev[1] = "";
    fn = "foo";
}
/^Working file/ {
    fn = $3;
}
/^revision/ {  rev[i] = $2;
    i++;
    if ( i == 2 ) {
        exit
    }
}
END {
    print "tkdiff -r " rev[0] " -r " rev[1] " " fn ;
    system("cvs log -r " rev[0] " " fn);
    system("tkdiff -r " rev[0] " -r " rev[1] " " fn);
}



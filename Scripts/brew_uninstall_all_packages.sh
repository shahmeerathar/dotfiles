while [[ `brew list | wc -l` -ne 0 ]]; do
    #Interate over each installed package
    for EACH in `brew list`; do
        #Uninstall each package
        brew uninstall --ignore-dependencies $EACH --force
    done
done

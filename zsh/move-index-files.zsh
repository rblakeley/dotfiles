function move_index_paths_to_named_paths() {
  setopt interactivecomments;

  indexPaths=($(find . -type f -mindepth 2 ! -path '*/.*' -path '*/index.*'));
  for indexPath in $indexPaths;
  do
    echo '--------------------'
    echo 'index path:' $indexPath
    currentParent=$(echo $indexPath | perl -pe 's/index.*//g');
    currentSiblings=($(find $currentParent -type f -depth 1 ! -path '*/.*' ! -path '*/index.*' -name '*'));
    currentSiblingsLength=($(find $currentParent -type f -depth 1 ! -path '*/.*' ! -path '*/index.*' -name '*' | wc -l));
    echo $currentSiblingsLength 'siblings' $currentSiblings;
    if [ $currentSiblingsLength -gt 0 ]
    then
      echo 'rename index without moving directories';
      # echo 'current parent:' $currentParent;
      currentParentFragment=$(echo $currentParent | perl -pe 's/\..*(?=\/[\w-]*\/$)//g');
      # echo 'current parent fragment:' $currentParentFragment;
      newFileFragment=$(echo $currentParentFragment | perl -pe 's/\///g');
      echo 'new file fragment:' $newFileFragment;
      indexPathExtension=$(echo $indexPath | perl -pe 's/.*(?=\..*$)//g');
      # echo 'extension:' $indexPathExtension;
      newPath="${currentParent}${newFileFragment}${indexPathExtension}";
      echo 'new path:' $newPath;
      mv $indexPath $newPath;

      echo 'update external references';
      externalPathsWithImportReference=($(rg "/$newFileFragment';$" -l));
      for externalFile in $externalPathsWithImportReference;
      do
        echo 'external file:' $externalFile;
        find $externalFile | xargs perl -p -i -e "s/\/$newFileFragment';$/\/$newFileFragment\/$newFileFragment';/g";
      done
    else
      newPath=$(echo $indexPath | perl -pe 's/\/index//g');
      echo 'move index up one level to new path:' $newPath;
      mv $indexPath $newPath;
      currentParentSubDirectoriesLength=($(find $currentParent -type d ! -path '*/.*' -name '*' | wc -l));
      if [ $currentParentSubDirectoriesLength -eq 0 ]
      then
        echo 'remove empty parent directory';
        rm -r $currentParent;
      fi
      echo 'update internal relative imports';
      find $newPath | xargs perl -p -i -e "s/from '\.\.\//from '.\//g";
      echo 'cleanup relative path syntax'
      find $newPath | xargs perl -p -i -e "s/from '\.\/\.\./from '.\./g";
    fi
  done
}

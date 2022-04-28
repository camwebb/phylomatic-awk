
# docker run -it alpine:latest
docker build -t phylomatic:latest .
docker run --rm -it -v `pwd`:`pwd` -w `pwd` phylomatic:latest \
       --newick phylo1 --taxa taxa1

# Push to Docker Hub
# docker login
# docker tag phylomatic camwebb/phylomatic
# docker push camwebb/phylomatic:latest

# Clean
# docker images -a -q | xargs docker rmi -f

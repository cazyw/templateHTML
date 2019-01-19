# Docker DynamoDB in Windows
#
# Prerequisites: docker toolbox
#
# 1. Start docker toolbox
# 2. run ./docker-dynamodb.sh
# 3. go to http://192.168.99.100:9000/


echo "Pulling latest from instructure/dynamo-local-admin"
docker pull instructure/dynamo-local-admin

echo "Run dynamo"
docker run --detach -p 9000:8000 -it --name dynamo instructure/dynamo-local-admin

echo "Starting docker"
docker start dynamo



# # docker run --detach --publish 9000:8000 --name test_dynamodb amazon/dynamodb-local -jar DynamoDBLocal.jar -sharedDb

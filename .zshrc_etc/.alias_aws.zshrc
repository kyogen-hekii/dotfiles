# -----
# aws
# -----
aws_profile_fzf() {
  export AWS_PROFILE="$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile \(.*\)\]$/\1/' | fzf)"
}

export AWS_PROFILE_DEFAULT=aws
alias AWSP="aws --profile $AWS_PROFILE_DEFAULT"
# ユーザープール一覧
alias aws_userpools '{$AWSP} cognito-idp list-user-pools --max-results 10'
# ユーザープールのクライアント一覧
alias aws_clients_by_userpoolid '{$AWSP} cognito-idp list-user-pool-clients --max-results 10 --user-pool-id'

# アイデンティティプール一覧
alias aws_idps '{$AWSP} cognito-identity list-identity-pools --max-results 10'
# aws --profile aws cognito-identity list-identity-pools --max-results 10 --query "IdentityPools[].IdentityPoolId"
# アイデンティティプール詳細
alias aws_idp_detail_by_idpid '{$AWSP} cognito-identity describe-identity-pool --identity-pool-id'
# idp, clientIdの一覧
alias aws_idp_detail_list '{$AWSP} cognito-identity list-identity-pools --max-results 10 --query "IdentityPools[].IdentityPoolId" | jq -r ".[]" | xargs -I {} aws --profile aws cognito-identity describe-identity-pool --identity-pool-id {} | jq "{idpName: .IdentityPoolName, idpId: .IdentityPoolId, clientId: .CognitoIdentityProviders[].ClientId}"'

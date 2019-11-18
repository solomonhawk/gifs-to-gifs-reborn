alias GifMe.DB.Repo
alias GifMe.DB.Accounts.{User, Role}

Repo.insert(%Role{type: "admin"})
Repo.insert(%Role{type: "player"})

Repo.insert(%User{
  nickname: "admin",
  email: "admin@gifme.pizza",
  role_id: Repo.get_by(Role, type: "admin").id,
  password_hash: "123abc"
})

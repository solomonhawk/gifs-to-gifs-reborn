alias GifMe.DB.Repo
alias GifMe.DB.Role

Repo.insert!(%Role{type: "admin"})
Repo.insert!(%Role{type: "user")}

  User.create!(name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              affiliation: "管理者",
              employee_number: 0,
              uid: 0,
              admin: true)

  User.create!(name: "上長A",
                email: "sample1@email.com",
                password: "password",
                password_confirmation: "password",
                affiliation: "役員",
                employee_number: 1,
                uid: 1,
                superior: true)

  User.create!(name: "上長B",
                email: "sample2@email.com",
                password: "password",
                password_confirmation: "password",
                affiliation: " 役員",
                employee_number: 2,
                uid: 2,
                superior: true)

  User.create!(name: "一般",
                email: "user1@email.com",
                password: "password",
                password_confirmation: "password",
                affiliation: " 社員",
                employee_number: 3,
                uid: 3,
                superior: true)              

    

        20.times do |n|
          name  = Faker::Name.name
          email = "sample-#{n+1}@email.com"
          password = "password"
          User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password)
        end
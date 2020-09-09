  User.create!(name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              department: "管理者",
              staff_id: 0,
              card_id: 0,
              admin: true)

  User.create!(name: "上長A",
                email: "sample1@email.com",
                password: "password",
                password_confirmation: "password",
                department: "役員",
                staff_id: 1,
                card_id: 1,
                superior: true)

  User.create!(name: "上長B",
                email: "sample2@email.com",
                password: "password",
                password_confirmation: "password",
                department: " 役員",
                staff_id: 2,
                card_id: 2,
                superior: true)

    User.create!(name: "一般A",
                  email: "sample3@email.com",
                  password: "password",
                  password_confirmation: "password",
                  department: "正職員",
                  staff_id: 3,
                  card_id: 3)

      User.create!(name: "一般B",
                    email: "sample4@email.com",
                    password: "password",
                    password_confirmation: "password",
                    department: "正職員",
                    staff_id: 4,
                    card_id: 4)


        20.times do |n|
          name  = Faker::Name.name
          email = "sample-#{n+1}@email.com"
          password = "password"
          User.create!(name: name,
                      email: email,
                      password: password,
                      password_confirmation: password)
        end
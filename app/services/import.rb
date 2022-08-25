# frozen_string_literal: true

# PROMPT:
# - This assignment assumes there is a Subscriber Model that contains Name, Email, and Status fields.
# - A Junior Developer was tasked with creating subscribers from a CSV file.
# - The CSV file is known to always be formated as `name`, `email` without any headers.
# - The developer was instructed to avoid creating multiple subscribers with the same email.
# - Any imported subscriber should be marked active, even if the subscriber exists already.
class Import
  attr_accessor :file

  def initialize(file)
    @file = file
  end

  def perform
    CSV.foreach(file) do |row|
      if row[0].present? || row[1].present?
        name = row[0]
        email = row[1]
        status = "active"
        cur_sub = Subscriber.where(email: email).first

        if cur_sub.present?
          if cur_sub.status == "active"
            return
          else
            cur_sub.update(status: status)
          end
        else
          Subscriber.create(name: name, email: email, status: status)
        end
      else
        return
      end
    end
  end
end

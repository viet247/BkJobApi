# Sử dụng Ruby 3.3 - phù hợp nhất với Rails 8
FROM ruby:3.3.0

# Cài đặt các thư viện hệ thống cần thiết cho MySQL và Rails
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    git \
    pkg-config \
    nodejs \
    npm

# Tạo thư mục làm việc
WORKDIR /app

# Copy Gemfile vào trước
COPY Gemfile Gemfile.lock ./

# Cài đặt Gem
RUN bundle install

# Copy toàn bộ dự án
COPY . .

# Thêm entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

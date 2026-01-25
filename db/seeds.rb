# db/seeds.rb

def log(msg)
  puts "[SEED] #{msg}"
end

log "Cleaning up old data..."

Apply.destroy_all
History.destroy_all
Favorite.destroy_all
Job.destroy_all
Company.destroy_all
City.destroy_all
Industry.destroy_all
Position.destroy_all
User.destroy_all

log "Database cleaned!"

# 1. CREATE USERS
log "Creating Users..."

# --- ADMIN ---
admin = User.create!(
  name: "System Admin",
  email: "admin@jobsearch.com",
  password: "123123",
  password_confirmation: "123123",
  role: 2,             # Admin
  login_id: "admin01",
  address: "Headquarters"
)

# --- CANDIDATE ---
candidate = User.create!(
  name: "Quang Viet",
  email: "candidate@test.com",
  password: "123123",
  password_confirmation: "123123",
  role: 1,             # Candidate
  address: "Quang Tri"
)

# --- DUMMY HR ---
dummy_hr = User.create!(
  name: "Dummy HR",
  email: "hr@dummy.com",
  password: "123123",
  password_confirmation: "123123",
  role: 1,
  address: "Virtual Office"
)

log "Users created: Admin (admin01), Candidate (candidate@test.com)"

# 2. CREATE MASTER DATA (Cities, Industries, POSITIONS)
log "Creating Master Data..."

domestic_cities = [ "Ha Noi", "Ho Chi Minh", "Da Nang", "Can Tho", "Hai Phong", "Binh Duong" ]
domestic_cities.each do |name|
  City.create!(
    name: name,
    slug: name.parameterize,
    area: 'domestic'
  )
end

foreign_cities = [ "Singapore", "Tokyo", "Seoul", "London", "Moscow", "Sydney", "Bangkok" ]
foreign_cities.each do |name|
  City.create!(
    name: name,
    slug: name.parameterize,
    area: 'foreign'
  )
end

cities = City.all

industries = [ "Software Development", "Marketing", "Finance", "Education", "Sales" ].map do |name|
  Industry.create!(name: name, slug: name.parameterize)
end

positions = [ "Intern", "Fresher", "Junior", "Middle", "Senior", "Tech Lead", "Manager", "Director" ].map do |title|
  Position.create!(title: title)
end

# 3. CREATE DUMMY COMPANIES
log "Creating Dummy Companies..."
company_names = [ "Tech Giants Inc.", "Global Solutions", "Creative Studio", "FinTech Asia" ]
companies = company_names.map do |name|
  Company.create!(
    name: name,
    address: "123 Business Street",
    description: "A leading company in the industry.",
    user: dummy_hr
  )
end

# 4. CREATE JOBS
log "Creating Jobs..."

job_titles = [
  "Ruby Developer",
  "React Engineer",
  "Project Manager",
  "Business Analyst",
  "DevOps Specialist",
  "Python Developer"
]

40.times do |i|
  # Random các quan hệ
  city = cities.sample
  industry = industries.sample
  company = companies.sample
  position = positions.sample # Lấy ngẫu nhiên 1 position

  Job.create!(
    title: "#{job_titles.sample} (#{position.title})",
    description: "We are looking for a talented individual to join our team.\nBenefits:\n- Competitive salary\n- Remote work options\n- Health insurance",
    salary: rand(800..5000),
    created_at: Time.now - rand(0..30).days,

    city: city,
    industry: industry,
    company: company,
    position: position
  )
end

log "Created 40 Jobs."

# 5. CREATE APPLIES
log "Creating Dummy Applications..."

dummy_cv_path = Rails.root.join('tmp', 'dummy_cv.txt')
File.open(dummy_cv_path, 'w') { |file| file.write("Here is the content of a sample CV for testing the system.") }

Job.all.sample(10).each do |job|
  apply = Apply.new(
    job: job,
    user: candidate,
    full_name: candidate.name,
    email: candidate.email,
    status: "pending",
    resume_url: "https://example.com/cv_link_fake.pdf"
  )

  apply.cv.attach(
    io: File.open(dummy_cv_path),
    filename: 'sample_cv.txt',
    content_type: 'text/plain'
  )

  apply.save!
end

File.delete(dummy_cv_path) if File.exist?(dummy_cv_path)

log "Seed data generation finished successfully!"

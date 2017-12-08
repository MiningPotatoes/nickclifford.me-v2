header
  .title
    h1 Nick Clifford
    .social-icons
      - config["icons"].each do |type, icons|
        - icons.each do |icon, settings|
          a href=settings[%{link}] target="_blank" title=settings[%{title}]
            - case type
            - when "fa"
              i class="fa fa-3x fa-#{icon}"
            - when "cc"
              i class="cc #{icon}-alt"


.about
  h2.section-heading Hello!
  p
    | I'm Nick Clifford, and I'm a back-end web developer, sysadmin, and webmaster.

.skills.flex-list
  h2.section-heading Skills and Experience
  .skills-list.flex-list__container
    - config["skills"].each do |skill|
      .skill.flex-list__item
        a href=skill[%{link}] target="_blank"
          i class="devicon-#{skill["devicon"]} colored"
        h2= skill["name"]

.projects.flex-list
  h2.section-heading Projects
  .projects-list.flex-list__container
    - config["projects"].each do |project|
      .project.flex-list__item
        h2= project["name"]
        a href=project[%{link}] target="_blank"
          img src=project[%{image}]
        p= project["desc"]

/ Inline markup isn't great in Slang, so we'll just use HTML
footer
  | Copyright <a href="https://github.com/nickbclifford/nickclifford.me-v2/blob/master/LICENSE" target="_blank">&copy; 2017</a> Nick Clifford. Powered by <a href="https://crystal-lang.org/" target="_blank">Crystal</a> and <a href="http://kemalcr.com/" target="_blank">Kemal.</a>
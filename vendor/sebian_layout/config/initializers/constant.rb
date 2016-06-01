class SebianLayoutConstant

  STATIC_TEXT_KEYS = [:copyright, :footer_tagline, :in_this_look, :in_this_look_subtext, :popular_weekly, :popular_weekly_subtext, :new_arrival,
    :new_arrival_subtext, :featured_designers, :featured_designers_subtext, :our_brands, :our_brands_subtext, :contact_location,  :contact_phone,
    :contact_email, :contact_skype, :contact_open_time, :title_footer_column_1, :title_footer_column_2, :blog_title,
    :title_footer_column_3, :the_blog, :the_blog_subtext, :instagram, :instagram_subtext, :instagram_tagline, :related_product_section_title, :related_product_section_tagline
  ]

  ENABLED_SECTION_KEYS = [:show_slider, :show_in_this_look, :show_3_boxes, :show_new_arrival,
                      :show_popular_weekly, :show_blog, :show_what_designer_says, :show_instagram_photos,
                      :show_featured_designers, :show_our_brands, :show_instagram_photos_footer, :show_loading_screen, :show_breadcrumb_in_entire_blog
  ]

  NEWSLETTER_SETTING_KEYS = [:newsletter_success_message, :newsletter_delay
  ]

  NEWSLETTER_TRIGGERS = {
      'atendpage'                =>  'Bottom Scroll',
      'onidle'              =>  'Scroll',
      'onload'               =>  'Display once the page is loaded'
  }

  NEWSLETTER_ANIMATIONS = {
      'fade'                =>  'Fade',
      'flyInRight'                =>  'Fly in right',
      'flyInLeft'                =>  'Fly in left',
      'flyInUp'                =>  'Fly in up',
      'flyInDown'                =>  'Fly in down'
  }

  MAILCHIMP_SETTING_KEYS = [:mailchimp_api_key, :mailchimp_list_id
  ]

  CONSTANT_CONTACT_SETTING_KEYS = [:constant_contact_api_key, :constant_contact_api_secret, :constant_contact_list_id
  ]

  SLIDER_ANIMATION = {
          'random'                =>  'random',
          'boxslide'              =>  'boxslide',
          'boxfade'               =>  'boxfade',
          'slotslide-horizontal'  =>  'slotslide-horizontal',
          'slotslide-vertical'    =>  'slotslide-vertical',
          'curtain-1'             =>  'curtain-1',
          'curtain-2'             =>  'curtain-2',
          'curtain-3'             =>  'curtain-3',
          'slotzoom-horizontal'   =>  'slotzoom-horizontal',
          'slotzoom-vertical'     =>  'slotzoom-vertical',
          'slotfade-horizontal'   =>  'slotfade-horizontal',
          'slotfade-vertical'     =>  'slotfade-vertical',
          'fade'                  =>  'fade',
          'slideleft'             =>  'slideleft',
          'slideup'               =>  'slideup',
          'slidedown'             =>  'slidedown',
          'slideright'            =>  'slideright',
          'papercut'              =>  'papercut',
          '3dcurtain-horizontal'  =>  '3dcurtain-horizontal',
          '3dcurtain-vertical'    =>  '3dcurtain-vertical',
          'cubic'                 =>  'cubic',
          'cube'                  =>  'cube',
          'flyin'                 =>  'flyin',
          'turnoff'               =>  'turnoff',
          'incube'                =>  'incube',
          'cubic-horizontal'      =>  'cubic-horizontal',
          'cube-horizontal'       =>  'cube-horizontal',
          'incube-horizontal'     =>  'incube-horizontal',
          'turnoff-vertical'      =>  'turnoff-vertical',
          'fadefromright'         =>  'fadefromright',
          'fadefromleft'          =>  'fadefromleft',
          'fadefromtop'           =>  'fadefromtop',
          'fadefrombottom'        =>  'fadefrombottom',
          'fadetoleftfadefromright'=> 'fadetoleftfadefromright',
          'fadetorightfadetoleft' =>  'fadetorightfadetoleft',
          'fadetobottomfadefromtop' =>  'fadetobottomfadefromtop',
          'fadetotopfadefrombottom' => 'fadetotopfadefrombottom',
          'parallaxtoright'       =>  'parallaxtoright',
          'parallaxtoleft'        =>  'parallaxtoleft',
          'parallaxtotop'         =>  'parallaxtotop',
          'parallaxtobottom'      =>  'parallaxtobottom',
          'scaledownfromright'    =>  'scaledownfromright',
          'scaledownfromleft'     =>  'scaledownfromleft',
          'scaledownfromtop'      =>  'scaledownfromtop',
          'scaledownfrombottom'   =>  'scaledownfrombottom',
          'zoomout'               =>  'zoomout',
          'zoomin'                =>  'zoomin',
          'notransition'          =>  'notransition'
  }

end
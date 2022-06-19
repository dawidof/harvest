// Import and register all your controllers from the importmap under controllers/*

// import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)


"use strict";

const toggleCSSclasses = (el, ...cls) => cls.map(cl => el.classList.toggle(cl))

/* Navbar: dropdown */
Array.from(document.getElementsByClassName('dropdown')).forEach(function (elA) {
  elA.addEventListener('click', function (e) {
    if (e.currentTarget.classList.contains('navbar-item')) {
      toggleCSSclasses(e.currentTarget, 'active text-black dark:text-white dark:hover:text-gray-400 text-blue-600'.split(' '))
      var menu = Array.from(e.currentTarget.children).filter(item => item.tagName == 'DIV')[0]
      menu.classList.toggle('lg:hidden');
    }
  });
});

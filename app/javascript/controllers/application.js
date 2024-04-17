import { Application } from "@hotwired/stimulus"
const application = Application.start()

import { Alert, Autosave, ColorPreview, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
import { Autocomplete } from 'stimulus-autocomplete'

application.register('autocomplete', Autocomplete)
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('color-preview', ColorPreview)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('popover', Popover)
application.register('slideover', Slideover)
application.register('tabs', Tabs)
application.register('toggle', Toggle)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

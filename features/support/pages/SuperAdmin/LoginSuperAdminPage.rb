class LoginSuperAdminPage < SitePrism::Page
    element :userSuperAdmin, 'input[name="superAdminEmail"]'
    element :passSuperAdmin, 'input[name="superAdminPassword"]'
    element :btnSuperAmin, '.sbButtonTextLink'
    
end
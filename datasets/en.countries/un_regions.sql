/* 
   This file is public domain.

   The data is a matter of public record, and comes from
   http://unstats.un.org/unsd/methods/m49/m49regin.htm

   2008-10-04
   
   Composition of macro geographical (continental) regions, geographical
   sub-regions, and selected economic and other groupings
 */


/* Geographical region and composition */

SET search_path TO sqltutor;

INSERT INTO un_regions VALUES (001, 'World');
INSERT INTO un_regions VALUES (002, 'Africa');
INSERT INTO un_regions VALUES (014, 'Eastern Africa');
INSERT INTO un_regions VALUES (017, 'Middle Africa');
INSERT INTO un_regions VALUES (015, 'Northern Africa');
INSERT INTO un_regions VALUES (018, 'Southern Africa');
INSERT INTO un_regions VALUES (011, 'Western Africa');
INSERT INTO un_regions VALUES (019, 'Americas');
INSERT INTO un_regions VALUES (419, 'Latin America and the Caribbean');
INSERT INTO un_regions VALUES (029, 'Caribbean');
INSERT INTO un_regions VALUES (013, 'Central America');
INSERT INTO un_regions VALUES (005, 'South America');
INSERT INTO un_regions VALUES (021, 'Northern America');
INSERT INTO un_regions VALUES (142, 'Asia');
INSERT INTO un_regions VALUES (143, 'Central Asia');
INSERT INTO un_regions VALUES (030, 'Eastern Asia');
INSERT INTO un_regions VALUES (034, 'Southern Asia');
INSERT INTO un_regions VALUES (035, 'South-Eastern Asia');
INSERT INTO un_regions VALUES (145, 'Western Asia');
INSERT INTO un_regions VALUES (150, 'Europe');
INSERT INTO un_regions VALUES (151, 'Eastern Europe');
INSERT INTO un_regions VALUES (154, 'Northern Europe');
INSERT INTO un_regions VALUES (039, 'Southern Europe');
INSERT INTO un_regions VALUES (155, 'Western Europe');
INSERT INTO un_regions VALUES (009, 'Oceania');
INSERT INTO un_regions VALUES (053, 'Australia and New Zealand');
INSERT INTO un_regions VALUES (054, 'Melanesia');
INSERT INTO un_regions VALUES (057, 'Micronesia');
INSERT INTO un_regions VALUES (061, 'Polynesia');

-- 002 Africa
-- 014 Eastern Africa 

INSERT INTO un_regions_countries VALUES(002, 108); -- Burundi                        
INSERT INTO un_regions_countries VALUES(002, 174); -- Comoros                        
INSERT INTO un_regions_countries VALUES(002, 262); -- Djibouti                       
INSERT INTO un_regions_countries VALUES(002, 232); -- Eritrea                        
INSERT INTO un_regions_countries VALUES(002, 231); -- Ethiopia                       
INSERT INTO un_regions_countries VALUES(002, 404); -- Kenya                          
INSERT INTO un_regions_countries VALUES(002, 450); -- Madagascar                     
INSERT INTO un_regions_countries VALUES(002, 454); -- Malawi                         
INSERT INTO un_regions_countries VALUES(002, 480); -- Mauritius                      
INSERT INTO un_regions_countries VALUES(002, 175); -- Mayotte                        
INSERT INTO un_regions_countries VALUES(002, 508); -- Mozambique                     
INSERT INTO un_regions_countries VALUES(002, 638); -- Réunion                        
INSERT INTO un_regions_countries VALUES(002, 646); -- Rwanda                         
INSERT INTO un_regions_countries VALUES(002, 690); -- Seychelles                     
INSERT INTO un_regions_countries VALUES(002, 706); -- Somalia                        
INSERT INTO un_regions_countries VALUES(002, 800); -- Uganda                         
INSERT INTO un_regions_countries VALUES(002, 834); -- United Republic of Tanzania    
INSERT INTO un_regions_countries VALUES(002, 894); -- Zambia                         
INSERT INTO un_regions_countries VALUES(002, 716); -- Zimbabwe                       

INSERT INTO un_regions_countries VALUES(014, 108); -- Burundi                        
INSERT INTO un_regions_countries VALUES(014, 174); -- Comoros                        
INSERT INTO un_regions_countries VALUES(014, 262); -- Djibouti                       
INSERT INTO un_regions_countries VALUES(014, 232); -- Eritrea                        
INSERT INTO un_regions_countries VALUES(014, 231); -- Ethiopia                       
INSERT INTO un_regions_countries VALUES(014, 404); -- Kenya                          
INSERT INTO un_regions_countries VALUES(014, 450); -- Madagascar                     
INSERT INTO un_regions_countries VALUES(014, 454); -- Malawi                         
INSERT INTO un_regions_countries VALUES(014, 480); -- Mauritius                      
INSERT INTO un_regions_countries VALUES(014, 175); -- Mayotte                        
INSERT INTO un_regions_countries VALUES(014, 508); -- Mozambique                     
INSERT INTO un_regions_countries VALUES(014, 638); -- Réunion                        
INSERT INTO un_regions_countries VALUES(014, 646); -- Rwanda                         
INSERT INTO un_regions_countries VALUES(014, 690); -- Seychelles                     
INSERT INTO un_regions_countries VALUES(014, 706); -- Somalia                        
INSERT INTO un_regions_countries VALUES(014, 800); -- Uganda                         
INSERT INTO un_regions_countries VALUES(014, 834); -- United Republic of Tanzania    
INSERT INTO un_regions_countries VALUES(014, 894); -- Zambia                         
INSERT INTO un_regions_countries VALUES(014, 716); -- Zimbabwe                       


-- 002 Africa
-- 017 Middle Africa

INSERT INTO un_regions_countries VALUES(002, 024); -- Angola
INSERT INTO un_regions_countries VALUES(002, 120); -- Cameroon
INSERT INTO un_regions_countries VALUES(002, 140); -- Central African Republic
INSERT INTO un_regions_countries VALUES(002, 148); -- Chad
INSERT INTO un_regions_countries VALUES(002, 178); -- Congo
INSERT INTO un_regions_countries VALUES(002, 180); -- Democratic Republic of the Congo
INSERT INTO un_regions_countries VALUES(002, 226); -- Equatorial Guinea
INSERT INTO un_regions_countries VALUES(002, 266); -- Gabon
INSERT INTO un_regions_countries VALUES(002, 678); -- Sao Tome and Principe 

INSERT INTO un_regions_countries VALUES(017, 024); -- Angola
INSERT INTO un_regions_countries VALUES(017, 120); -- Cameroon
INSERT INTO un_regions_countries VALUES(017, 140); -- Central African Republic
INSERT INTO un_regions_countries VALUES(017, 148); -- Chad
INSERT INTO un_regions_countries VALUES(017, 178); -- Congo
INSERT INTO un_regions_countries VALUES(017, 180); -- Democratic Republic of the Congo
INSERT INTO un_regions_countries VALUES(017, 226); -- Equatorial Guinea
INSERT INTO un_regions_countries VALUES(017, 266); -- Gabon
INSERT INTO un_regions_countries VALUES(017, 678); -- Sao Tome and Principe 

 	 
-- 002 Africa
-- 015 Northern Africa

INSERT INTO un_regions_countries VALUES(002, 012); -- Algeria
INSERT INTO un_regions_countries VALUES(002, 818); -- Egypt
INSERT INTO un_regions_countries VALUES(002, 434); -- Libyan Arab Jamahiriya
INSERT INTO un_regions_countries VALUES(002, 504); -- Morocco
INSERT INTO un_regions_countries VALUES(002, 736); -- Sudan
INSERT INTO un_regions_countries VALUES(002, 788); -- Tunisia
INSERT INTO un_regions_countries VALUES(002, 732); -- Western Sahara

INSERT INTO un_regions_countries VALUES(015, 012); -- Algeria
INSERT INTO un_regions_countries VALUES(015, 818); -- Egypt
INSERT INTO un_regions_countries VALUES(015, 434); -- Libyan Arab Jamahiriya
INSERT INTO un_regions_countries VALUES(015, 504); -- Morocco
INSERT INTO un_regions_countries VALUES(015, 736); -- Sudan
INSERT INTO un_regions_countries VALUES(015, 788); -- Tunisia
INSERT INTO un_regions_countries VALUES(015, 732); -- Western Sahara


-- 002 Africa
-- 018 Southern Africa

INSERT INTO un_regions_countries VALUES(002, 072); -- Botswana
INSERT INTO un_regions_countries VALUES(002, 426); -- Lesotho
INSERT INTO un_regions_countries VALUES(002, 516); -- Namibia
INSERT INTO un_regions_countries VALUES(002, 710); -- South Africa
INSERT INTO un_regions_countries VALUES(002, 748); -- Swaziland 

INSERT INTO un_regions_countries VALUES(018, 072); -- Botswana
INSERT INTO un_regions_countries VALUES(018, 426); -- Lesotho
INSERT INTO un_regions_countries VALUES(018, 516); -- Namibia
INSERT INTO un_regions_countries VALUES(018, 710); -- South Africa
INSERT INTO un_regions_countries VALUES(018, 748); -- Swaziland 


-- 002 Africa
-- 011 Western Africa

INSERT INTO un_regions_countries VALUES(002, 204); -- Benin
INSERT INTO un_regions_countries VALUES(002, 854); -- Burkina Faso
INSERT INTO un_regions_countries VALUES(002, 132); -- Cape Verde
INSERT INTO un_regions_countries VALUES(002, 384); -- Cote d'Ivoire
INSERT INTO un_regions_countries VALUES(002, 270); -- Gambia
INSERT INTO un_regions_countries VALUES(002, 288); -- Ghana
INSERT INTO un_regions_countries VALUES(002, 324); -- Guinea
INSERT INTO un_regions_countries VALUES(002, 624); -- Guinea-Bissau
INSERT INTO un_regions_countries VALUES(002, 430); -- Liberia
INSERT INTO un_regions_countries VALUES(002, 466); -- Mali
INSERT INTO un_regions_countries VALUES(002, 478); -- Mauritania
INSERT INTO un_regions_countries VALUES(002, 562); -- Niger
INSERT INTO un_regions_countries VALUES(002, 566); -- Nigeria
INSERT INTO un_regions_countries VALUES(002, 654); -- Saint Helena
INSERT INTO un_regions_countries VALUES(002, 686); -- Senegal
INSERT INTO un_regions_countries VALUES(002, 694); -- Sierra Leone
INSERT INTO un_regions_countries VALUES(002, 768); -- Togo

INSERT INTO un_regions_countries VALUES(011, 204); -- Benin
INSERT INTO un_regions_countries VALUES(011, 854); -- Burkina Faso
INSERT INTO un_regions_countries VALUES(011, 132); -- Cape Verde
INSERT INTO un_regions_countries VALUES(011, 384); -- Cote d'Ivoire
INSERT INTO un_regions_countries VALUES(011, 270); -- Gambia
INSERT INTO un_regions_countries VALUES(011, 288); -- Ghana
INSERT INTO un_regions_countries VALUES(011, 324); -- Guinea
INSERT INTO un_regions_countries VALUES(011, 624); -- Guinea-Bissau
INSERT INTO un_regions_countries VALUES(011, 430); -- Liberia
INSERT INTO un_regions_countries VALUES(011, 466); -- Mali
INSERT INTO un_regions_countries VALUES(011, 478); -- Mauritania
INSERT INTO un_regions_countries VALUES(011, 562); -- Niger
INSERT INTO un_regions_countries VALUES(011, 566); -- Nigeria
INSERT INTO un_regions_countries VALUES(011, 654); -- Saint Helena
INSERT INTO un_regions_countries VALUES(011, 686); -- Senegal
INSERT INTO un_regions_countries VALUES(011, 694); -- Sierra Leone
INSERT INTO un_regions_countries VALUES(011, 768); -- Togo


-- 019 Americas
-- 419 Latin America and the Caribbean
-- 029 Caribbean

INSERT INTO un_regions_countries VALUES(019, 660); -- Anguilla
INSERT INTO un_regions_countries VALUES(019, 028); -- Antigua and Barbuda
INSERT INTO un_regions_countries VALUES(019, 533); -- Aruba
INSERT INTO un_regions_countries VALUES(019, 044); -- Bahamas
INSERT INTO un_regions_countries VALUES(019, 052); -- Barbados
INSERT INTO un_regions_countries VALUES(019, 092); -- British Virgin Islands
INSERT INTO un_regions_countries VALUES(019, 136); -- Cayman Islands
INSERT INTO un_regions_countries VALUES(019, 192); -- Cuba
INSERT INTO un_regions_countries VALUES(019, 212); -- Dominica
INSERT INTO un_regions_countries VALUES(019, 214); -- Dominican Republic
INSERT INTO un_regions_countries VALUES(019, 308); -- Grenada
INSERT INTO un_regions_countries VALUES(019, 312); -- Guadeloupe
INSERT INTO un_regions_countries VALUES(019, 332); -- Haiti
INSERT INTO un_regions_countries VALUES(019, 388); -- Jamaica
INSERT INTO un_regions_countries VALUES(019, 474); -- Martinique
INSERT INTO un_regions_countries VALUES(019, 500); -- Montserrat
INSERT INTO un_regions_countries VALUES(019, 530); -- Netherlands Antilles
INSERT INTO un_regions_countries VALUES(019, 630); -- Puerto Rico
INSERT INTO un_regions_countries VALUES(019, 652); -- Saint-Barthélemy
INSERT INTO un_regions_countries VALUES(019, 659); -- Saint Kitts and Nevis
INSERT INTO un_regions_countries VALUES(019, 662); -- Saint Lucia
INSERT INTO un_regions_countries VALUES(019, 663); -- Saint Martin (French part)
INSERT INTO un_regions_countries VALUES(019, 670); -- Saint Vincent and the Grenadines
INSERT INTO un_regions_countries VALUES(019, 780); -- Trinidad and Tobago
INSERT INTO un_regions_countries VALUES(019, 796); -- Turks and Caicos Islands
INSERT INTO un_regions_countries VALUES(019, 850); -- United States Virgin Islands 

INSERT INTO un_regions_countries VALUES(419, 660); -- Anguilla
INSERT INTO un_regions_countries VALUES(419, 028); -- Antigua and Barbuda
INSERT INTO un_regions_countries VALUES(419, 533); -- Aruba
INSERT INTO un_regions_countries VALUES(419, 044); -- Bahamas
INSERT INTO un_regions_countries VALUES(419, 052); -- Barbados
INSERT INTO un_regions_countries VALUES(419, 092); -- British Virgin Islands
INSERT INTO un_regions_countries VALUES(419, 136); -- Cayman Islands
INSERT INTO un_regions_countries VALUES(419, 192); -- Cuba
INSERT INTO un_regions_countries VALUES(419, 212); -- Dominica
INSERT INTO un_regions_countries VALUES(419, 214); -- Dominican Republic
INSERT INTO un_regions_countries VALUES(419, 308); -- Grenada
INSERT INTO un_regions_countries VALUES(419, 312); -- Guadeloupe
INSERT INTO un_regions_countries VALUES(419, 332); -- Haiti
INSERT INTO un_regions_countries VALUES(419, 388); -- Jamaica
INSERT INTO un_regions_countries VALUES(419, 474); -- Martinique
INSERT INTO un_regions_countries VALUES(419, 500); -- Montserrat
INSERT INTO un_regions_countries VALUES(419, 530); -- Netherlands Antilles
INSERT INTO un_regions_countries VALUES(419, 630); -- Puerto Rico
INSERT INTO un_regions_countries VALUES(419, 652); -- Saint-Barthélemy
INSERT INTO un_regions_countries VALUES(419, 659); -- Saint Kitts and Nevis
INSERT INTO un_regions_countries VALUES(419, 662); -- Saint Lucia
INSERT INTO un_regions_countries VALUES(419, 663); -- Saint Martin (French part)
INSERT INTO un_regions_countries VALUES(419, 670); -- Saint Vincent and the Grenadines
INSERT INTO un_regions_countries VALUES(419, 780); -- Trinidad and Tobago
INSERT INTO un_regions_countries VALUES(419, 796); -- Turks and Caicos Islands
INSERT INTO un_regions_countries VALUES(419, 850); -- United States Virgin Islands 

INSERT INTO un_regions_countries VALUES(029, 660); -- Anguilla
INSERT INTO un_regions_countries VALUES(029, 028); -- Antigua and Barbuda
INSERT INTO un_regions_countries VALUES(029, 533); -- Aruba
INSERT INTO un_regions_countries VALUES(029, 044); -- Bahamas
INSERT INTO un_regions_countries VALUES(029, 052); -- Barbados
INSERT INTO un_regions_countries VALUES(029, 092); -- British Virgin Islands
INSERT INTO un_regions_countries VALUES(029, 136); -- Cayman Islands
INSERT INTO un_regions_countries VALUES(029, 192); -- Cuba
INSERT INTO un_regions_countries VALUES(029, 212); -- Dominica
INSERT INTO un_regions_countries VALUES(029, 214); -- Dominican Republic
INSERT INTO un_regions_countries VALUES(029, 308); -- Grenada
INSERT INTO un_regions_countries VALUES(029, 312); -- Guadeloupe
INSERT INTO un_regions_countries VALUES(029, 332); -- Haiti
INSERT INTO un_regions_countries VALUES(029, 388); -- Jamaica
INSERT INTO un_regions_countries VALUES(029, 474); -- Martinique
INSERT INTO un_regions_countries VALUES(029, 500); -- Montserrat
INSERT INTO un_regions_countries VALUES(029, 530); -- Netherlands Antilles
INSERT INTO un_regions_countries VALUES(029, 630); -- Puerto Rico
INSERT INTO un_regions_countries VALUES(029, 652); -- Saint-Barthélemy
INSERT INTO un_regions_countries VALUES(029, 659); -- Saint Kitts and Nevis
INSERT INTO un_regions_countries VALUES(029, 662); -- Saint Lucia
INSERT INTO un_regions_countries VALUES(029, 663); -- Saint Martin (French part)
INSERT INTO un_regions_countries VALUES(029, 670); -- Saint Vincent and the Grenadines
INSERT INTO un_regions_countries VALUES(029, 780); -- Trinidad and Tobago
INSERT INTO un_regions_countries VALUES(029, 796); -- Turks and Caicos Islands
INSERT INTO un_regions_countries VALUES(029, 850); -- United States Virgin Islands 


-- 019 Americas
-- 419 Latin America and the Caribbean
-- 013 Central America

INSERT INTO un_regions_countries VALUES(019, 084); -- Belize
INSERT INTO un_regions_countries VALUES(019, 188); -- Costa Rica
INSERT INTO un_regions_countries VALUES(019, 222); -- El Salvador
INSERT INTO un_regions_countries VALUES(019, 320); -- Guatemala
INSERT INTO un_regions_countries VALUES(019, 340); -- Honduras
INSERT INTO un_regions_countries VALUES(019, 484); -- Mexico
INSERT INTO un_regions_countries VALUES(019, 558); -- Nicaragua
INSERT INTO un_regions_countries VALUES(019, 591); -- Panama 

INSERT INTO un_regions_countries VALUES(419, 084); -- Belize
INSERT INTO un_regions_countries VALUES(419, 188); -- Costa Rica
INSERT INTO un_regions_countries VALUES(419, 222); -- El Salvador
INSERT INTO un_regions_countries VALUES(419, 320); -- Guatemala
INSERT INTO un_regions_countries VALUES(419, 340); -- Honduras
INSERT INTO un_regions_countries VALUES(419, 484); -- Mexico
INSERT INTO un_regions_countries VALUES(419, 558); -- Nicaragua
INSERT INTO un_regions_countries VALUES(419, 591); -- Panama 

INSERT INTO un_regions_countries VALUES(013, 084); -- Belize
INSERT INTO un_regions_countries VALUES(013, 188); -- Costa Rica
INSERT INTO un_regions_countries VALUES(013, 222); -- El Salvador
INSERT INTO un_regions_countries VALUES(013, 320); -- Guatemala
INSERT INTO un_regions_countries VALUES(013, 340); -- Honduras
INSERT INTO un_regions_countries VALUES(013, 484); -- Mexico
INSERT INTO un_regions_countries VALUES(013, 558); -- Nicaragua
INSERT INTO un_regions_countries VALUES(013, 591); -- Panama 


-- 019 Americas
-- 419 Latin America and the Caribbean
-- 005 South America

INSERT INTO un_regions_countries VALUES(019, 032); -- Argentina
INSERT INTO un_regions_countries VALUES(019, 068); -- Bolivia
INSERT INTO un_regions_countries VALUES(019, 076); -- Brazil
INSERT INTO un_regions_countries VALUES(019, 152); -- Chile
INSERT INTO un_regions_countries VALUES(019, 170); -- Colombia
INSERT INTO un_regions_countries VALUES(019, 218); -- Ecuador
INSERT INTO un_regions_countries VALUES(019, 238); -- Falkland Islands (Malvinas)
INSERT INTO un_regions_countries VALUES(019, 254); -- French Guiana
INSERT INTO un_regions_countries VALUES(019, 328); -- Guyana
INSERT INTO un_regions_countries VALUES(019, 600); -- Paraguay
INSERT INTO un_regions_countries VALUES(019, 604); -- Peru
INSERT INTO un_regions_countries VALUES(019, 740); -- Suriname
INSERT INTO un_regions_countries VALUES(019, 858); -- Uruguay
INSERT INTO un_regions_countries VALUES(019, 862); -- Venezuela (Bolivarian Republic of)

INSERT INTO un_regions_countries VALUES(419, 032); -- Argentina
INSERT INTO un_regions_countries VALUES(419, 068); -- Bolivia
INSERT INTO un_regions_countries VALUES(419, 076); -- Brazil
INSERT INTO un_regions_countries VALUES(419, 152); -- Chile
INSERT INTO un_regions_countries VALUES(419, 170); -- Colombia
INSERT INTO un_regions_countries VALUES(419, 218); -- Ecuador
INSERT INTO un_regions_countries VALUES(419, 238); -- Falkland Islands (Malvinas)
INSERT INTO un_regions_countries VALUES(419, 254); -- French Guiana
INSERT INTO un_regions_countries VALUES(419, 328); -- Guyana
INSERT INTO un_regions_countries VALUES(419, 600); -- Paraguay
INSERT INTO un_regions_countries VALUES(419, 604); -- Peru
INSERT INTO un_regions_countries VALUES(419, 740); -- Suriname
INSERT INTO un_regions_countries VALUES(419, 858); -- Uruguay
INSERT INTO un_regions_countries VALUES(419, 862); -- Venezuela (Bolivarian Republic of)

INSERT INTO un_regions_countries VALUES(005, 032); -- Argentina
INSERT INTO un_regions_countries VALUES(005, 068); -- Bolivia
INSERT INTO un_regions_countries VALUES(005, 076); -- Brazil
INSERT INTO un_regions_countries VALUES(005, 152); -- Chile
INSERT INTO un_regions_countries VALUES(005, 170); -- Colombia
INSERT INTO un_regions_countries VALUES(005, 218); -- Ecuador
INSERT INTO un_regions_countries VALUES(005, 238); -- Falkland Islands (Malvinas)
INSERT INTO un_regions_countries VALUES(005, 254); -- French Guiana
INSERT INTO un_regions_countries VALUES(005, 328); -- Guyana
INSERT INTO un_regions_countries VALUES(005, 600); -- Paraguay
INSERT INTO un_regions_countries VALUES(005, 604); -- Peru
INSERT INTO un_regions_countries VALUES(005, 740); -- Suriname
INSERT INTO un_regions_countries VALUES(005, 858); -- Uruguay
INSERT INTO un_regions_countries VALUES(005, 862); -- Venezuela (Bolivarian Republic of)


-- 019 Americas
-- 419 Latin America and the Caribbean
-- 021 Northern America

INSERT INTO un_regions_countries VALUES(019, 060); -- Bermuda
INSERT INTO un_regions_countries VALUES(019, 124); -- Canada
INSERT INTO un_regions_countries VALUES(019, 304); -- Greenland
INSERT INTO un_regions_countries VALUES(019, 666); -- Saint Pierre and Miquelon
INSERT INTO un_regions_countries VALUES(019, 840); -- United States of America

INSERT INTO un_regions_countries VALUES(419, 060); -- Bermuda
INSERT INTO un_regions_countries VALUES(419, 124); -- Canada
INSERT INTO un_regions_countries VALUES(419, 304); -- Greenland
INSERT INTO un_regions_countries VALUES(419, 666); -- Saint Pierre and Miquelon
INSERT INTO un_regions_countries VALUES(419, 840); -- United States of America

INSERT INTO un_regions_countries VALUES(021, 060); -- Bermuda
INSERT INTO un_regions_countries VALUES(021, 124); -- Canada
INSERT INTO un_regions_countries VALUES(021, 304); -- Greenland
INSERT INTO un_regions_countries VALUES(021, 666); -- Saint Pierre and Miquelon
INSERT INTO un_regions_countries VALUES(021, 840); -- United States of America


-- 142 Asia
-- 143 Central Asia

INSERT INTO un_regions_countries VALUES(142, 398); -- Kazakhstan
INSERT INTO un_regions_countries VALUES(142, 417); -- Kyrgyzstan
INSERT INTO un_regions_countries VALUES(142, 762); -- Tajikistan
INSERT INTO un_regions_countries VALUES(142, 795); -- Turkmenistan
INSERT INTO un_regions_countries VALUES(142, 860); -- Uzbekistan 

INSERT INTO un_regions_countries VALUES(143, 398); -- Kazakhstan
INSERT INTO un_regions_countries VALUES(143, 417); -- Kyrgyzstan
INSERT INTO un_regions_countries VALUES(143, 762); -- Tajikistan
INSERT INTO un_regions_countries VALUES(143, 795); -- Turkmenistan
INSERT INTO un_regions_countries VALUES(143, 860); -- Uzbekistan 


-- 142 Asia
-- 030 Eastern Asia

INSERT INTO un_regions_countries VALUES(142, 156); -- China
INSERT INTO un_regions_countries VALUES(142, 344); -- Hong Kong 
INSERT INTO un_regions_countries VALUES(142, 446); -- Macao
INSERT INTO un_regions_countries VALUES(142, 408); -- Dem. People's Republic of Korea
INSERT INTO un_regions_countries VALUES(142, 392); -- Japan
INSERT INTO un_regions_countries VALUES(142, 496); -- Mongolia
INSERT INTO un_regions_countries VALUES(142, 410); -- Republic of Korea 

INSERT INTO un_regions_countries VALUES(030, 156); -- China
INSERT INTO un_regions_countries VALUES(030, 344); -- Hong Kong
INSERT INTO un_regions_countries VALUES(030, 446); -- Macao 
INSERT INTO un_regions_countries VALUES(030, 408); -- Dem. People's Republic of Korea
INSERT INTO un_regions_countries VALUES(030, 392); -- Japan
INSERT INTO un_regions_countries VALUES(030, 496); -- Mongolia
INSERT INTO un_regions_countries VALUES(030, 410); -- Republic of Korea 


-- 142 Asia
-- 034 Southern Asia

INSERT INTO un_regions_countries VALUES(142, 004); -- Afghanistan
INSERT INTO un_regions_countries VALUES(142, 050); -- Bangladesh
INSERT INTO un_regions_countries VALUES(142, 064); -- Bhutan
INSERT INTO un_regions_countries VALUES(142, 356); -- India
INSERT INTO un_regions_countries VALUES(142, 364); -- Iran, Islamic Republic of
INSERT INTO un_regions_countries VALUES(142, 462); -- Maldives
INSERT INTO un_regions_countries VALUES(142, 524); -- Nepal
INSERT INTO un_regions_countries VALUES(142, 586); -- Pakistan
INSERT INTO un_regions_countries VALUES(142, 144); -- Sri Lanka 

INSERT INTO un_regions_countries VALUES(034, 004); -- Afghanistan
INSERT INTO un_regions_countries VALUES(034, 050); -- Bangladesh
INSERT INTO un_regions_countries VALUES(034, 064); -- Bhutan
INSERT INTO un_regions_countries VALUES(034, 356); -- India
INSERT INTO un_regions_countries VALUES(034, 364); -- Iran, Islamic Republic of
INSERT INTO un_regions_countries VALUES(034, 462); -- Maldives
INSERT INTO un_regions_countries VALUES(034, 524); -- Nepal
INSERT INTO un_regions_countries VALUES(034, 586); -- Pakistan
INSERT INTO un_regions_countries VALUES(034, 144); -- Sri Lanka 


-- 142 Asia
-- 035 South-Eastern Asia

INSERT INTO un_regions_countries VALUES(142, 096); -- Brunei Darussalam
INSERT INTO un_regions_countries VALUES(142, 116); -- Cambodia
INSERT INTO un_regions_countries VALUES(142, 360); -- Indonesia
INSERT INTO un_regions_countries VALUES(142, 418); -- Laos
INSERT INTO un_regions_countries VALUES(142, 458); -- Malaysia
INSERT INTO un_regions_countries VALUES(142, 104); -- Myanmar
INSERT INTO un_regions_countries VALUES(142, 608); -- Philippines
INSERT INTO un_regions_countries VALUES(142, 702); -- Singapore
INSERT INTO un_regions_countries VALUES(142, 764); -- Thailand
INSERT INTO un_regions_countries VALUES(142, 626); -- Timor-Leste
INSERT INTO un_regions_countries VALUES(142, 704); -- Viet Nam 

INSERT INTO un_regions_countries VALUES(035, 096); -- Brunei Darussalam
INSERT INTO un_regions_countries VALUES(035, 116); -- Cambodia
INSERT INTO un_regions_countries VALUES(035, 360); -- Indonesia
INSERT INTO un_regions_countries VALUES(035, 418); -- Laos
INSERT INTO un_regions_countries VALUES(035, 458); -- Malaysia
INSERT INTO un_regions_countries VALUES(035, 104); -- Myanmar
INSERT INTO un_regions_countries VALUES(035, 608); -- Philippines
INSERT INTO un_regions_countries VALUES(035, 702); -- Singapore
INSERT INTO un_regions_countries VALUES(035, 764); -- Thailand
INSERT INTO un_regions_countries VALUES(035, 626); -- Timor-Leste
INSERT INTO un_regions_countries VALUES(035, 704); -- Viet Nam 


-- 142 Asia
-- 145 Western Asia

INSERT INTO un_regions_countries VALUES(142, 051); -- Armenia
INSERT INTO un_regions_countries VALUES(142, 031); -- Azerbaijan
INSERT INTO un_regions_countries VALUES(142, 048); -- Bahrain
INSERT INTO un_regions_countries VALUES(142, 196); -- Cyprus
INSERT INTO un_regions_countries VALUES(142, 268); -- Georgia
INSERT INTO un_regions_countries VALUES(142, 368); -- Iraq
INSERT INTO un_regions_countries VALUES(142, 376); -- Israel
INSERT INTO un_regions_countries VALUES(142, 400); -- Jordan
INSERT INTO un_regions_countries VALUES(142, 414); -- Kuwait
INSERT INTO un_regions_countries VALUES(142, 422); -- Lebanon
INSERT INTO un_regions_countries VALUES(142, 275); -- Palestinian Territory
INSERT INTO un_regions_countries VALUES(142, 512); -- Oman
INSERT INTO un_regions_countries VALUES(142, 634); -- Qatar
INSERT INTO un_regions_countries VALUES(142, 682); -- Saudi Arabia
INSERT INTO un_regions_countries VALUES(142, 760); -- Syrian Arab Republic
INSERT INTO un_regions_countries VALUES(142, 792); -- Turkey
INSERT INTO un_regions_countries VALUES(142, 784); -- United Arab Emirates
INSERT INTO un_regions_countries VALUES(142, 887); -- Yemen 

INSERT INTO un_regions_countries VALUES(145, 051); -- Armenia
INSERT INTO un_regions_countries VALUES(145, 031); -- Azerbaijan
INSERT INTO un_regions_countries VALUES(145, 048); -- Bahrain
INSERT INTO un_regions_countries VALUES(145, 196); -- Cyprus
INSERT INTO un_regions_countries VALUES(145, 268); -- Georgia
INSERT INTO un_regions_countries VALUES(145, 368); -- Iraq
INSERT INTO un_regions_countries VALUES(145, 376); -- Israel
INSERT INTO un_regions_countries VALUES(145, 400); -- Jordan
INSERT INTO un_regions_countries VALUES(145, 414); -- Kuwait
INSERT INTO un_regions_countries VALUES(145, 422); -- Lebanon
INSERT INTO un_regions_countries VALUES(145, 275); -- Palestinian Territory
INSERT INTO un_regions_countries VALUES(145, 512); -- Oman
INSERT INTO un_regions_countries VALUES(145, 634); -- Qatar
INSERT INTO un_regions_countries VALUES(145, 682); -- Saudi Arabia
INSERT INTO un_regions_countries VALUES(145, 760); -- Syrian Arab Republic
INSERT INTO un_regions_countries VALUES(145, 792); -- Turkey
INSERT INTO un_regions_countries VALUES(145, 784); -- United Arab Emirates
INSERT INTO un_regions_countries VALUES(145, 887); -- Yemen 


-- 150 Europe
-- 151 Eastern Europe 

INSERT INTO un_regions_countries VALUES(150, 112); -- Belarus
INSERT INTO un_regions_countries VALUES(150, 100); -- Bulgaria
INSERT INTO un_regions_countries VALUES(150, 203); -- Czech Republic
INSERT INTO un_regions_countries VALUES(150, 348); -- Hungary
INSERT INTO un_regions_countries VALUES(150, 498); -- Moldova
INSERT INTO un_regions_countries VALUES(150, 616); -- Poland
INSERT INTO un_regions_countries VALUES(150, 642); -- Romania
INSERT INTO un_regions_countries VALUES(150, 643); -- Russian Federation
INSERT INTO un_regions_countries VALUES(150, 703); -- Slovakia
INSERT INTO un_regions_countries VALUES(150, 804); -- Ukraine 

INSERT INTO un_regions_countries VALUES(151, 112); -- Belarus
INSERT INTO un_regions_countries VALUES(151, 100); -- Bulgaria
INSERT INTO un_regions_countries VALUES(151, 203); -- Czech Republic
INSERT INTO un_regions_countries VALUES(151, 348); -- Hungary
INSERT INTO un_regions_countries VALUES(151, 498); -- Moldova
INSERT INTO un_regions_countries VALUES(151, 616); -- Poland
INSERT INTO un_regions_countries VALUES(151, 642); -- Romania
INSERT INTO un_regions_countries VALUES(151, 643); -- Russian Federation
INSERT INTO un_regions_countries VALUES(151, 703); -- Slovakia
INSERT INTO un_regions_countries VALUES(151, 804); -- Ukraine 


-- 150 Europe
-- 154 Northern Europe

INSERT INTO un_regions_countries VALUES(150, 248); -- Åland Islands
-- INSERT INTO un_regions_countries VALUES(150, 830); -- Channel slands
INSERT INTO un_regions_countries VALUES(150, 208); -- Denmark
INSERT INTO un_regions_countries VALUES(150, 233); -- Estonia
INSERT INTO un_regions_countries VALUES(150, 234); -- Faeroe Islands
INSERT INTO un_regions_countries VALUES(150, 246); -- Finland
INSERT INTO un_regions_countries VALUES(150, 831); -- Gurnsey
INSERT INTO un_regions_countries VALUES(150, 352); -- Iceland
INSERT INTO un_regions_countries VALUES(150, 372); -- Ireland
INSERT INTO un_regions_countries VALUES(150, 833); -- Isle of Man
INSERT INTO un_regions_countries VALUES(150, 832); -- Jerse
INSERT INTO un_regions_countries VALUES(150, 428); -- Latvia
INSERT INTO un_regions_countries VALUES(150, 440); -- Lithuania
INSERT INTO un_regions_countries VALUES(150, 578); -- Norway
INSERT INTO un_regions_countries VALUES(150, 744); -- Svalbard and Jan Mayen Islands
INSERT INTO un_regions_countries VALUES(150, 752); -- Sweden
INSERT INTO un_regions_countries VALUES(150, 826); -- UK

INSERT INTO un_regions_countries VALUES(154, 248); -- Åland Islands
-- INSERT INTO un_regions_countries VALUES(154, 830); -- Channel slands
INSERT INTO un_regions_countries VALUES(154, 208); -- Denmark
INSERT INTO un_regions_countries VALUES(154, 233); -- Estonia
INSERT INTO un_regions_countries VALUES(154, 234); -- Faeroe Islands
INSERT INTO un_regions_countries VALUES(154, 246); -- Finland
INSERT INTO un_regions_countries VALUES(154, 831); -- Gurnsey
INSERT INTO un_regions_countries VALUES(154, 352); -- Iceland
INSERT INTO un_regions_countries VALUES(154, 372); -- Ireland
INSERT INTO un_regions_countries VALUES(154, 833); -- Isle of Man
INSERT INTO un_regions_countries VALUES(154, 832); -- Jerse
INSERT INTO un_regions_countries VALUES(154, 428); -- Latvia
INSERT INTO un_regions_countries VALUES(154, 440); -- Lithuania
INSERT INTO un_regions_countries VALUES(154, 578); -- Norway
INSERT INTO un_regions_countries VALUES(154, 744); -- Svalbard and Jan Mayen Islands
INSERT INTO un_regions_countries VALUES(154, 752); -- Sweden
INSERT INTO un_regions_countries VALUES(154, 826); -- UK


-- 150 Europe
-- 039 Southern Europe

INSERT INTO un_regions_countries VALUES(150, 008); -- Albania
INSERT INTO un_regions_countries VALUES(150, 020); -- Andorra
INSERT INTO un_regions_countries VALUES(150, 070); -- Bosnia and Herzegovina
INSERT INTO un_regions_countries VALUES(150, 191); -- Croatia
INSERT INTO un_regions_countries VALUES(150, 292); -- Gibraltar
INSERT INTO un_regions_countries VALUES(150, 300); -- Greece
INSERT INTO un_regions_countries VALUES(150, 336); -- Holy See
INSERT INTO un_regions_countries VALUES(150, 380); -- Italy
INSERT INTO un_regions_countries VALUES(150, 470); -- Malta
INSERT INTO un_regions_countries VALUES(150, 499); -- Montenegro
INSERT INTO un_regions_countries VALUES(150, 620); -- Portugal
INSERT INTO un_regions_countries VALUES(150, 674); -- San Marino
INSERT INTO un_regions_countries VALUES(150, 688); -- Serbia
INSERT INTO un_regions_countries VALUES(150, 705); -- Slovenia
INSERT INTO un_regions_countries VALUES(150, 724); -- Spain
INSERT INTO un_regions_countries VALUES(150, 807); -- Macedonia 

INSERT INTO un_regions_countries VALUES(039, 008); -- Albania
INSERT INTO un_regions_countries VALUES(039, 020); -- Andorra
INSERT INTO un_regions_countries VALUES(039, 070); -- Bosnia and Herzegovina
INSERT INTO un_regions_countries VALUES(039, 191); -- Croatia
INSERT INTO un_regions_countries VALUES(039, 292); -- Gibraltar
INSERT INTO un_regions_countries VALUES(039, 300); -- Greece
INSERT INTO un_regions_countries VALUES(039, 336); -- Holy See
INSERT INTO un_regions_countries VALUES(039, 380); -- Italy
INSERT INTO un_regions_countries VALUES(039, 470); -- Malta
INSERT INTO un_regions_countries VALUES(039, 499); -- Montenegro
INSERT INTO un_regions_countries VALUES(039, 620); -- Portugal
INSERT INTO un_regions_countries VALUES(039, 674); -- San Marino
INSERT INTO un_regions_countries VALUES(039, 688); -- Serbia
INSERT INTO un_regions_countries VALUES(039, 705); -- Slovenia
INSERT INTO un_regions_countries VALUES(039, 724); -- Spain
INSERT INTO un_regions_countries VALUES(039, 807); -- Macedonia 


-- 150 Europe
-- 155 Western Europe

INSERT INTO un_regions_countries VALUES(150, 040); -- Austria
INSERT INTO un_regions_countries VALUES(150, 056); -- Belgium
INSERT INTO un_regions_countries VALUES(150, 250); -- France
INSERT INTO un_regions_countries VALUES(150, 276); -- Germany
INSERT INTO un_regions_countries VALUES(150, 438); -- Liechtenstein
INSERT INTO un_regions_countries VALUES(150, 442); -- Luxembourg
INSERT INTO un_regions_countries VALUES(150, 492); -- Monaco
INSERT INTO un_regions_countries VALUES(150, 528); -- Netherlands
INSERT INTO un_regions_countries VALUES(150, 756); -- Switzerland 

INSERT INTO un_regions_countries VALUES(155, 040); -- Austria
INSERT INTO un_regions_countries VALUES(155, 056); -- Belgium
INSERT INTO un_regions_countries VALUES(155, 250); -- France
INSERT INTO un_regions_countries VALUES(155, 276); -- Germany
INSERT INTO un_regions_countries VALUES(155, 438); -- Liechtenstein
INSERT INTO un_regions_countries VALUES(155, 442); -- Luxembourg
INSERT INTO un_regions_countries VALUES(155, 492); -- Monaco
INSERT INTO un_regions_countries VALUES(155, 528); -- Netherlands
INSERT INTO un_regions_countries VALUES(155, 756); -- Switzerland 


-- 009 Oceania
-- 053 Australia and New Zealand

INSERT INTO un_regions_countries VALUES(009, 036); -- Australia
INSERT INTO un_regions_countries VALUES(009, 554); -- New Zealand
INSERT INTO un_regions_countries VALUES(009, 574); -- Norfolk Island 

INSERT INTO un_regions_countries VALUES(053, 036); -- Australia
INSERT INTO un_regions_countries VALUES(053, 554); -- New Zealand
INSERT INTO un_regions_countries VALUES(053, 574); -- Norfolk Island 


-- 009 Oceania
-- 054 Melanesia

INSERT INTO un_regions_countries VALUES(009, 242); -- Fiji
INSERT INTO un_regions_countries VALUES(009, 540); -- New Caledonia
INSERT INTO un_regions_countries VALUES(009, 598); -- Papua New Guinea
INSERT INTO un_regions_countries VALUES(009, 090); -- Solomon Islands
INSERT INTO un_regions_countries VALUES(009, 548); -- Vanuatu 

INSERT INTO un_regions_countries VALUES(054, 242); -- Fiji
INSERT INTO un_regions_countries VALUES(054, 540); -- New Caledonia
INSERT INTO un_regions_countries VALUES(054, 598); -- Papua New Guinea
INSERT INTO un_regions_countries VALUES(054, 090); -- Solomon Islands
INSERT INTO un_regions_countries VALUES(054, 548); -- Vanuatu 


-- 009 Oceania
-- 057 Micronesia

INSERT INTO un_regions_countries VALUES(009, 316); -- Guam
INSERT INTO un_regions_countries VALUES(009, 296); -- Kiribati
INSERT INTO un_regions_countries VALUES(009, 584); -- Marshall Islands
INSERT INTO un_regions_countries VALUES(009, 583); -- Micronesia
INSERT INTO un_regions_countries VALUES(009, 520); -- Nauru
INSERT INTO un_regions_countries VALUES(009, 580); -- Northern Mariana Islands
INSERT INTO un_regions_countries VALUES(009, 585); -- Palau 

INSERT INTO un_regions_countries VALUES(057, 316); -- Guam
INSERT INTO un_regions_countries VALUES(057, 296); -- Kiribati
INSERT INTO un_regions_countries VALUES(057, 584); -- Marshall Islands
INSERT INTO un_regions_countries VALUES(057, 583); -- Micronesia
INSERT INTO un_regions_countries VALUES(057, 520); -- Nauru
INSERT INTO un_regions_countries VALUES(057, 580); -- Northern Mariana Islands
INSERT INTO un_regions_countries VALUES(057, 585); -- Palau 


-- 009 Oceania
-- 061 Polynesia

INSERT INTO un_regions_countries VALUES(009, 016); -- American Samoa
INSERT INTO un_regions_countries VALUES(009, 184); -- Cook Islands
INSERT INTO un_regions_countries VALUES(009, 258); -- French Polynesia
INSERT INTO un_regions_countries VALUES(009, 570); -- Niue
INSERT INTO un_regions_countries VALUES(009, 612); -- Pitcairn
INSERT INTO un_regions_countries VALUES(009, 882); -- Samoa
INSERT INTO un_regions_countries VALUES(009, 772); -- Tokelau
INSERT INTO un_regions_countries VALUES(009, 776); -- Tonga
INSERT INTO un_regions_countries VALUES(009, 798); -- Tuvalu
INSERT INTO un_regions_countries VALUES(009, 876); -- Wallis and Futuna Islands 

INSERT INTO un_regions_countries VALUES(061, 016); -- American Samoa
INSERT INTO un_regions_countries VALUES(061, 184); -- Cook Islands
INSERT INTO un_regions_countries VALUES(061, 258); -- French Polynesia
INSERT INTO un_regions_countries VALUES(061, 570); -- Niue
INSERT INTO un_regions_countries VALUES(061, 612); -- Pitcairn
INSERT INTO un_regions_countries VALUES(061, 882); -- Samoa
INSERT INTO un_regions_countries VALUES(061, 772); -- Tokelau
INSERT INTO un_regions_countries VALUES(061, 776); -- Tonga
INSERT INTO un_regions_countries VALUES(061, 798); -- Tuvalu
INSERT INTO un_regions_countries VALUES(061, 876); -- Wallis and Futuna Islands 


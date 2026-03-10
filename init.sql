CREATE TABLE Art1
(
    museumAddress CHAR(40),
    location      CHAR(20),
    PRIMARY KEY (museumAddress)
);
CREATE TABLE Art2
(
    artId           INT,
    museumName      CHAR(40),
    museumAddress   CHAR(40),
    ownerEmail      CHAR(40) NOT NULL,
    materialType    CHAR(20) NOT NULL,
    artistId        INT      NOT NULL,
    creationYear    INT,
    conditionStatus CHAR(20),
    dimensions      CHAR(60),
    title           CHAR(80) NOT NULL,
    PRIMARY KEY (artId)
);
CREATE TABLE Painting
(
    artId       INT,
    surfaceType CHAR(20),
    paintType   CHAR(20),
    PRIMARY KEY (artId)
);
CREATE TABLE Sculpture
(
    artId                   INT,
    installationRequirement CHAR(20),
    weight                  INT,
    PRIMARY KEY (artId)
);
CREATE TABLE MediumDurabilityPolicy
(
    durability          CHAR(20),
    storageRequirements CHAR(60),
    PRIMARY KEY (durability)
);
CREATE TABLE MediumHazardDurability
(
    hazardLevel CHAR(20),
    durability  CHAR(20),
    PRIMARY KEY (hazardLevel)
);
CREATE TABLE MediumMaterialHazard
(
    materialType CHAR(20),
    hazardLevel  CHAR(20),
    PRIMARY KEY (materialType)
);
CREATE TABLE MaintenanceRecord
(
    artId            INT,
    recordNumber     INT,
    costEstimate     DECIMAL(10, 2) NOT NULL,
    maintDate        DATE           NOT NULL,
    treatmentType    CHAR(20),
    Notes            CHAR(100),
    conservatorEmail CHAR(40),
    PRIMARY KEY (artId, recordNumber)
);
CREATE TABLE Guard1
(
    securityLevel   INT,
    providerCompany CHAR(40) NOT NULL,
    cost            INT,
    PRIMARY KEY (securityLevel, providerCompany)
);
CREATE TABLE Guard2
(
    guardBadgeNumber INT,
    museumName       CHAR(40) NOT NULL,
    museumAddress    CHAR(40) NOT NULL,
    securityLevel    INT,
    providerCompany  CHAR(40) NOT NULL,
    name             CHAR(20) NOT NULL,
    PRIMARY KEY (guardBadgeNumber)
);
CREATE TABLE Owner
(
    ownerEmail   CHAR(40),
    ownerName    CHAR(40) NOT NULL,
    ownerCountry CHAR(20),
    ownerType    CHAR(20),
    PRIMARY KEY (ownerEmail)
);
CREATE TABLE Conservator1
(
    conservatorEmail CHAR(40),
    conservatorName  CHAR(20) NOT NULL,
    phoneNumber      CHAR(20),
    certification    CHAR(40),
    museumName       CHAR(40) NOT NULL,
    museumAddress    CHAR(40) NOT NULL,
    PRIMARY KEY (conservatorEmail)
);
CREATE TABLE Conservator2
(
    certification  CHAR(40),
    specialization CHAR(40),
    PRIMARY KEY (certification)
);
CREATE TABLE Museum1
(
    museumAddress CHAR(40),
    city          CHAR(20) NOT NULL,
    PRIMARY KEY (museumAddress)
);
CREATE TABLE Museum2
(
    museumAddress CHAR(40),
    country       CHAR(20),
    PRIMARY KEY (museumAddress)
);
CREATE TABLE Museum3
(
    museumName     CHAR(40),
    museumAddress  CHAR(40),
    foundingYear   INT,
    annualVisitors INT,
    PRIMARY KEY (museumName, museumAddress)
);
CREATE TABLE Artist
(
    artistId    INT,
    artistName  CHAR(40) NOT NULL,
    birthYear   INT,
    deathYear   INT,
    Nationality CHAR(20),
    PRIMARY KEY (artistId)
);
CREATE TABLE Loan
(
    artId         INT,
    museumName    CHAR(40),
    museumAddress CHAR(40),
    ownerEmail    CHAR(40),
    PRIMARY KEY (
                 artId, museumName, museumAddress,
                 ownerEmail
        )
);


ALTER TABLE Art1
    ADD FOREIGN KEY (museumAddress) REFERENCES Museum1 (museumAddress) ON DELETE CASCADE;

ALTER TABLE Art2
    ADD FOREIGN KEY (museumName, museumAddress) REFERENCES Museum3 (museumName, museumAddress) ON DELETE SET NULL;
ALTER TABLE Art2
    ADD FOREIGN KEY (ownerEmail) REFERENCES Owner;
ALTER TABLE Art2
    ADD FOREIGN KEY (materialType) REFERENCES MediumMaterialHazard (materialType);
ALTER TABLE Art2
    ADD FOREIGN KEY (artistId) REFERENCES Artist (artistId);

ALTER TABLE Painting
    ADD FOREIGN KEY (artId) REFERENCES Art2 (artId) ON DELETE CASCADE;
ALTER TABLE Sculpture
    ADD FOREIGN KEY (artId) REFERENCES Art2 (artId) ON DELETE CASCADE;
ALTER TABLE MediumHazardDurability
    ADD FOREIGN KEY (durability) REFERENCES MediumDurabilityPolicy (durability);
ALTER TABLE MediumMaterialHazard
    ADD FOREIGN KEY (hazardLevel) REFERENCES MediumHazardDurability (hazardLevel);
ALTER TABLE MaintenanceRecord
    ADD FOREIGN KEY (artId) REFERENCES Art2 (artId) ON DELETE CASCADE;
ALTER TABLE MaintenanceRecord
    ADD FOREIGN KEY (conservatorEmail) REFERENCES Conservator1 (conservatorEmail) ON DELETE CASCADE;

ALTER TABLE Guard2
    ADD FOREIGN KEY (museumName, museumAddress) REFERENCES Museum3 (museumName, museumAddress) ON DELETE CASCADE;
ALTER TABLE Guard2
    ADD FOREIGN KEY (securityLevel, providerCompany) REFERENCES Guard1 (securityLevel, providerCompany) ON DELETE CASCADE;

ALTER TABLE Conservator1
    ADD FOREIGN KEY (certification) REFERENCES Conservator2 (certification);
ALTER TABLE Conservator1
    ADD FOREIGN KEY (museumName, museumAddress) REFERENCES Museum3 (museumName, museumAddress) ON DELETE CASCADE;

ALTER TABLE Museum2
    ADD FOREIGN KEY (museumAddress) REFERENCES Museum1 (museumAddress) ON DELETE CASCADE;
ALTER TABLE Museum3
    ADD FOREIGN KEY (museumAddress) REFERENCES Museum1 (museumAddress) ON DELETE CASCADE;

ALTER TABLE Loan
    ADD FOREIGN KEY (artId) REFERENCES Art2 (artId) ON DELETE CASCADE;
ALTER TABLE Loan
    ADD FOREIGN KEY (museumName, museumAddress) REFERENCES Museum3 (museumName, museumAddress) ON DELETE CASCADE;
ALTER TABLE Loan
    ADD FOREIGN KEY (ownerEmail) REFERENCES Owner (ownerEmail) ON DELETE CASCADE;

INSERT INTO Museum1 VALUES('1 Rue de la Légion d''Honneur', 'Paris');
INSERT INTO Museum2 VALUES('1 Rue de la Légion d''Honneur', 'France');
INSERT INTO Museum3 VALUES('Musée d''Orsay', '1 Rue de la Légion d''Honneur', 1986, 3780000);

INSERT INTO Museum1 VALUES('11 West 53rd Street', 'New York');
INSERT INTO Museum2 VALUES('11 West 53rd Street', 'United States');
INSERT INTO Museum3 VALUES('The Museum of Modern Art', '11 West 53rd Street', 1929, 2800000);

INSERT INTO Museum1 VALUES('2, Dvortsovaya Ploschad', 'Saint Petersburg');
INSERT INTO Museum2 VALUES('2, Dvortsovaya Ploschad', 'Russia');
INSERT INTO Museum3 VALUES('The State Hermitage Museum', '2, Dvortsovaya Ploschad', 1764, 2800000);

INSERT INTO Museum1 VALUES('99 Rue de Rivoli', 'Paris');
INSERT INTO Museum2 VALUES('99 Rue de Rivoli', 'France');
INSERT INTO Museum3 VALUES('The Louvre', '99 Rue de Rivoli', 1764, 8700000);

INSERT INTO Museum1 VALUES('Trafalgar Square', 'London');
INSERT INTO Museum2 VALUES('Trafalgar Square', 'United Kingdom');
INSERT INTO Museum3 VALUES('The National Gallery', 'Trafalgar Square', 1824, 4300000);

INSERT INTO Artist VALUES(1, 'Claude Monet', 1840, 1926, 'French');
INSERT INTO Artist VALUES(2, 'Pablo Picasso', 1881, 1973, 'Spanish');
INSERT INTO Artist VALUES(3, 'Vincent Van Gogh', 1853, 1890, 'Dutch');
INSERT INTO Artist VALUES(4, 'Yayoi Kusama', 1929, NULL, 'Japanese');
INSERT INTO Artist VALUES(5, 'Leonardo Da Vinci', 1452, 1519, 'Italian');
INSERT INTO Artist VALUES(6, 'Brandon Raoul', 1878, 1941, 'French');
INSERT INTO Artist VALUES(7, 'August Karl Speiss', 1807, 1904, 'Russian');
INSERT INTO Artist VALUES(8, 'Aimé Jules Dalou', 1838, 1902, 'French');
INSERT INTO Artist VALUES(9, 'Isa Genzken', 1948, NULL, 'German');

INSERT INTO Owner VALUES('information@moma.org', 'The MOMA Collections', 'United States', 'Organization');
INSERT INTO Owner VALUES('contact@pinaultcollection.com', 'François Pinault', 'France', 'Private Collection');
INSERT INTO Owner VALUES('contact@abramovichcollection.com', 'Roman Abramovich', 'Russia', 'Private Collection');
INSERT INTO Owner VALUES('contact@benesseart.com', 'Benesse Art Site Naoshima', 'Japan', 'Organization');
INSERT INTO Owner VALUES('collection@royalfamily.org.uk', 'Royal Family','United Kingdom', 'Organization');

INSERT INTO MediumDurabilityPolicy VALUES('High', 'None');
INSERT INTO MediumDurabilityPolicy VALUES('Medium', 'Temperature controlled, moderate light');
INSERT INTO MediumDurabilityPolicy VALUES('Low', 'Temperature controlled, moderate light, low humidity');
INSERT INTO MediumDurabilityPolicy VALUES('Very Low', '18 to 21 degrees, low light, low humidity');
INSERT INTO MediumDurabilityPolicy VALUES('Extremely Fragile', '18 to 21 degrees, low light, 50% relative humidity');

INSERT INTO MediumHazardDurability VALUES('5', 'Extremely Fragile');
INSERT INTO MediumHazardDurability VALUES('4', 'Very Low');
INSERT INTO MediumHazardDurability VALUES('3', 'Low');
INSERT INTO MediumHazardDurability VALUES('2', 'Medium');
INSERT INTO MediumHazardDurability VALUES('1', 'High');

INSERT INTO MediumMaterialHazard VALUES('Cement', '1');
INSERT INTO MediumMaterialHazard VALUES('Oil on canvas', '3');
INSERT INTO MediumMaterialHazard VALUES('Watercolour', '4');
INSERT INTO MediumMaterialHazard VALUES('Acrylic', '2');
INSERT INTO MediumMaterialHazard VALUES('Pastel', '5');
INSERT INTO MediumMaterialHazard VALUES('Graphite', '5');
INSERT INTO MediumMaterialHazard VALUES('Ink on paper', '5');
INSERT INTO MediumMaterialHazard VALUES('Fabric', '4');
INSERT INTO MediumMaterialHazard VALUES('Metal', '2');
INSERT INTO MediumMaterialHazard VALUES('Bisque porcelain', '3');


INSERT INTO Guard1 VALUES(1, 'Palladin', 500);
INSERT INTO Guard1 VALUES(5, 'Elite Security', 50000);
INSERT INTO Guard1 VALUES(4, 'IKF Protection', 10000);
INSERT INTO Guard1 VALUES(3, 'Rubio Private Security', 7000);
INSERT INTO Guard1 VALUES(3, 'Axiom', 1000);

INSERT INTO Art1 VALUES('1 Rue de la Légion d''Honneur', '7th arrondissement');
INSERT INTO Art2 VALUES(1, 'Musée d''Orsay', '1 Rue de la Légion d''Honneur', 'contact@pinaultcollection.com', 'Oil on canvas', 1, 1916, 'Good', 'H:204cm; L:200cm', 'Nymphéas bleus');

INSERT INTO Art2 VALUES(2, 'Musée d''Orsay', '1 Rue de la Légion d''Honneur', 'contact@pinaultcollection.com', 'Pastel', 6, 1913, 'Good', 'H:94cm; L:128cm', 'Immeuble parisien, angle de l''avenue du Maine et de la rue Mouton-Duvernet');

INSERT INTO Art1 VALUES('11 West 53rd Street', 'Midtown');
INSERT INTO Art2 VALUES(3, 'The Museum of Modern Art', '11 West 53rd Street', 'information@moma.org', 'Oil on canvas', 3, 1889, 'Needs Maintenance', 'H:73.7cm; L:92.1cm', 'The Starry Night');

INSERT INTO Art2 VALUES(4, 'The Museum of Modern Art', '11 West 53rd Street', 'contact@benesseart.com', 'Ink on paper', 4, 1952, 'Good', 'H:40cm; L:30cm', 'Untitled');

INSERT INTO Art1 VALUES('99 Rue de Rivoli', '1st arrondissement');
INSERT INTO Art1 VALUES('2, Dvortsovaya Ploschad', 'Central District');
INSERT INTO Art1 VALUES('Trafalgar Square', 'Charring Cross');

INSERT INTO Art2 VALUES(5, 'The Louvre', '99 Rue de Rivoli', 'contact@abramovichcollection.com', 'Oil on canvas', 5, 1503, 'Needs Maintenance', 'H:77cm; L:53cm', 'Mona Lisa');

INSERT INTO Art2 VALUES(6, 'The State Hermitage Museum', '2, Dvortsovaya Ploschad', 'contact@abramovichcollection.com', 'Oil on canvas', 2, 1901, 'Needs Maintenance', 'H:73cm; L:54cm', 'Absinthe Drinker');
INSERT INTO Art2 VALUES(7, 'The Museum of Modern Art', '11 West 53rd Street', 'contact@benesseart.com', 'Fabric', 4, 1962, 'Good', 'H:94cm; L:99cm; W:103cm', 'Accumulation No. 1');
INSERT INTO Art2 VALUES(8, 'The Museum of Modern Art', '11 West 53rd Street', 'information@moma.org', 'Metal', 2, 1914, 'Good', 'H:77.5cm; W:35cm; L:19.3cm', 'Guitar');
INSERT INTO Art2 VALUES(9, 'The State Hermitage Museum', '2, Dvortsovaya Ploschad', 'contact@abramovichcollection.com', 'Bisque porcelain', 7, 1905, 'Good', '46.8cm x 22.5cm x 18.5 cm', 'Sculpture: Woman');
INSERT INTO Art2 VALUES(10, 'Musée d''Orsay', '1 Rue de la Légion d''Honneur', 'contact@pinaultcollection.com', 'Cement', 8, 1902, 'Good', '20cm x 13.5cm x 9 cm', 'Jeune fille');
INSERT INTO Art2 VALUES(11, 'The National Gallery', 'Trafalgar Square', 'collection@royalfamily.org.uk', 'Watercolour', 1, 1873, 'Good', '75cm x 100cm', 'The Museum at Le Havre');
INSERT INTO Art2 VALUES(12, 'The Museum of Modern Art', '11 West 53rd Street', 'contact@benesseart.com', 'Metal', 9, 2007, 'Good', '1097.3 x 289.6 x 106.7 cm', 'Rose II');

INSERT INTO Painting VALUES(1, 'Canvas', 'Oil');
INSERT INTO Painting VALUES(3, 'Canvas', 'Oil');
INSERT INTO Painting VALUES(5, 'Canvas', 'Oil');
INSERT INTO Painting VALUES(6, 'Canvas', 'Oil');
INSERT INTO Painting VALUES(11, 'Canvas', 'Oil');

INSERT INTO Sculpture VALUES(7, 'None', 150);
INSERT INTO Sculpture VALUES(8, 'Wall mount', 3);
INSERT INTO Sculpture VALUES(9, 'Pedestal', 10);
INSERT INTO Sculpture VALUES(10, 'Wall mount', 7);
INSERT INTO Sculpture VALUES(12, 'Reinforced base', 7);

INSERT INTO Conservator2 VALUES('MA in Art Conservation', 'Painting conservation');
INSERT INTO Conservator2 VALUES('ISA Certificate', 'Sculpture conservation');
INSERT INTO Conservator2 VALUES('PhD in Historical Preservation', 'Historical Artifact Maintenance');
INSERT INTO Conservator2 VALUES('MA in Textiles', 'Textile Maintenance');
INSERT INTO Conservator2 VALUES('MA in Woodwork', 'Wood Conservation');

INSERT INTO Conservator1 VALUES('megankelly@royalsociety.org.uk', 'Megan Kelly', '312 345 8900', 'MA in Art Conservation','The National Gallery', 'Trafalgar Square');
INSERT INTO Conservator1 VALUES('bessy@louvre.fr', 'Claude Bessy', '485 990 3425', 'PhD in Historical Preservation','The Louvre', '99 Rue de Rivoli');
INSERT INTO Conservator1 VALUES('vladmir-malakhov@statemuseum.ru', 'Vladmir Malakhov', '908 909 2839', 'ISA Certificate','The State Hermitage Museum', '2, Dvortsovaya Ploschad');
INSERT INTO Conservator1 VALUES('khloe@moma.com', 'Khloe Kardashian', '234 303 2039', 'MA in Woodwork','The Museum of Modern Art', '11 West 53rd Street');
INSERT INTO Conservator1 VALUES('dupont.auelie@orsay.fr', 'Aurelie Dupont', '485 290 3883', 'MA in Textiles','Musée d''Orsay', '1 Rue de la Légion d''Honneur');

INSERT INTO Guard2 VALUES(1289, 'The Louvre', '99 Rue de Rivoli', 4, 'IKF Protection', 'Francois Alu');
INSERT INTO Guard2 VALUES(3490, 'The Louvre', '99 Rue de Rivoli', 4, 'IKF Protection', 'Anais Kovacs');
INSERT INTO Guard2 VALUES(4521, 'The Museum of Modern Art', '11 West 53rd Street', 3, 'Axiom', 'Chrishelle Straus');
INSERT INTO Guard2 VALUES(8924, 'The State Hermitage Museum', '2, Dvortsovaya Ploschad', 5, 'Elite Security', 'Ulyana Lopatkina');
INSERT INTO Guard2 VALUES(4324, 'The National Gallery', 'Trafalgar Square', 1, 'Palladin', 'Gordon Lightfoot');

INSERT INTO MaintenanceRecord VALUES(2, 1, 500.34, TO_DATE('15-MAR-2024','DD-MON-YYYY'), 'Protective coating', 'Next treatment needed March 2026','megankelly@royalsociety.org.uk');
INSERT INTO MaintenanceRecord VALUES(4, 2, 7800.89, TO_DATE('12-SEP-2025','DD-MON-YYYY'), 'Protective coating', 'Next treatment needed March 2027','megankelly@royalsociety.org.uk');
INSERT INTO MaintenanceRecord VALUES(11, 3, 40.34, TO_DATE('03-JAN-2019','DD-MON-YYYY'), 'Pigment restoration', 'N/A','bessy@louvre.fr');
INSERT INTO MaintenanceRecord VALUES(7, 4, 5000.00, TO_DATE('06-APR-2025','DD-MON-YYYY'), 'Fabric Maintenance', 'N/A','dupont.auelie@orsay.fr');
INSERT INTO MaintenanceRecord VALUES(12, 5, 750.00, TO_DATE('19-AUG-2024','DD-MON-YYYY'), 'Wash and Polish', 'Nearby construction site causing fast buildup of dirt, wash weekly until construction is over','dupont.auelie@orsay.fr');

INSERT INTO Loan VALUES(7, 'The Museum of Modern Art', '11 West 53rd Street', 'contact@benesseart.com');
INSERT INTO Loan VALUES(12, 'The Museum of Modern Art', '11 West 53rd Street', 'contact@benesseart.com');
INSERT INTO Loan VALUES(9, 'The State Hermitage Museum', '2, Dvortsovaya Ploschad', 'contact@abramovichcollection.com');
INSERT INTO Loan VALUES(10, 'Musée d''Orsay', '1 Rue de la Légion d''Honneur', 'contact@pinaultcollection.com');
INSERT INTO Loan VALUES(11, 'The National Gallery', 'Trafalgar Square', 'collection@royalfamily.org.uk');
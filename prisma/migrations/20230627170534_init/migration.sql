-- CreateEnum
CREATE TYPE "TypeGender" AS ENUM ('mare', 'gelding', 'stallion');

-- CreateEnum
CREATE TYPE "TypeTab" AS ENUM ('news', 'veterinarian', 'farrier');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('admin', 'user');

-- CreateTable
CREATE TABLE "horses" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "birthday" TIMESTAMP(3),
    "gender" "TypeGender",
    "profile_image_url" TEXT,
    "place" TEXT,
    "images" TEXT[],
    "create_as_parent" BOOLEAN NOT NULL DEFAULT false,
    "father_name" TEXT,
    "mother_name" TEXT,

    CONSTRAINT "horses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "News" (
    "id" SERIAL NOT NULL,
    "type" "TypeTab" NOT NULL DEFAULT 'news',
    "horse_name" TEXT,

    CONSTRAINT "News_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NewsTab" (
    "id" SERIAL NOT NULL,
    "date" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "executed_by" TEXT,
    "news_id" INTEGER,

    CONSTRAINT "NewsTab_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Veterinarian" (
    "id" SERIAL NOT NULL,
    "type" "TypeTab" NOT NULL DEFAULT 'veterinarian',
    "horse_name" TEXT,

    CONSTRAINT "Veterinarian_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VetTab" (
    "id" SERIAL NOT NULL,
    "date" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "executed_by" TEXT,
    "vet_id" INTEGER,

    CONSTRAINT "VetTab_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Farrier" (
    "id" SERIAL NOT NULL,
    "type" "TypeTab" NOT NULL DEFAULT 'farrier',
    "horse_name" TEXT,

    CONSTRAINT "Farrier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FarrierTab" (
    "id" SERIAL NOT NULL,
    "date" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "executed_by" TEXT,
    "farrier_id" INTEGER,

    CONSTRAINT "FarrierTab_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PhotosEntity" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "src" TEXT NOT NULL,
    "alt" TEXT NOT NULL,
    "horse_name" TEXT NOT NULL,

    CONSTRAINT "PhotosEntity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "activated" BOOLEAN NOT NULL DEFAULT false,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT,
    "role" "Role" NOT NULL DEFAULT 'user',
    "emailVerified" TIMESTAMP(3),
    "activated" BOOLEAN DEFAULT true,
    "image" TEXT,
    "password" TEXT,
    "premissions" TEXT[],

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "horses_name_key" ON "horses"("name");

-- CreateIndex
CREATE UNIQUE INDEX "News_horse_name_key" ON "News"("horse_name");

-- CreateIndex
CREATE UNIQUE INDEX "Veterinarian_horse_name_key" ON "Veterinarian"("horse_name");

-- CreateIndex
CREATE UNIQUE INDEX "Farrier_horse_name_key" ON "Farrier"("horse_name");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "VerificationToken"("identifier", "token");

-- AddForeignKey
ALTER TABLE "horses" ADD CONSTRAINT "horses_father_name_fkey" FOREIGN KEY ("father_name") REFERENCES "horses"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "horses" ADD CONSTRAINT "horses_mother_name_fkey" FOREIGN KEY ("mother_name") REFERENCES "horses"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "News" ADD CONSTRAINT "News_horse_name_fkey" FOREIGN KEY ("horse_name") REFERENCES "horses"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NewsTab" ADD CONSTRAINT "NewsTab_news_id_fkey" FOREIGN KEY ("news_id") REFERENCES "News"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Veterinarian" ADD CONSTRAINT "Veterinarian_horse_name_fkey" FOREIGN KEY ("horse_name") REFERENCES "horses"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VetTab" ADD CONSTRAINT "VetTab_vet_id_fkey" FOREIGN KEY ("vet_id") REFERENCES "Veterinarian"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Farrier" ADD CONSTRAINT "Farrier_horse_name_fkey" FOREIGN KEY ("horse_name") REFERENCES "horses"("name") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FarrierTab" ADD CONSTRAINT "FarrierTab_farrier_id_fkey" FOREIGN KEY ("farrier_id") REFERENCES "Farrier"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PhotosEntity" ADD CONSTRAINT "PhotosEntity_horse_name_fkey" FOREIGN KEY ("horse_name") REFERENCES "horses"("name") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

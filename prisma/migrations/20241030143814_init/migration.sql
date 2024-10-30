/*
  Warnings:

  - You are about to drop the column `picture_name` on the `Category` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Category" DROP COLUMN "picture_name",
ADD COLUMN     "pictureName" TEXT;
